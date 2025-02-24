import SwiftUI

struct Organizer: Identifiable {
    let id = UUID()
    let name: String
    let logoURL: String
}

struct OrganizersView: View {
    @State private var organizers: [Organizer] = []
    @State private var isLoading = true
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Cargando organizadores...") // 🔹 Placeholder mientras se cargan los datos
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(organizers) { organizer in
                            OrganizerCard(organizer: organizer)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .onAppear {
            Task {
                await loadOrganizers()
            }
        }
    }
    
    private func loadOrganizers() async {
        let urls = [
            "https://picsum.photos/200?random=1",
            "https://picsum.photos/200?random=2",
            "https://picsum.photos/200?random=3",
            "https://picsum.photos/200?random=4",
            "https://picsum.photos/200?random=5",
            "https://picsum.photos/200?random=6"
        ]

        let preloadedImages = await urls.concurrentMap { url -> Organizer in
            if let imageURL = URL(string: url), let _ = try? Data(contentsOf: imageURL) {
                return Organizer(name: "Org \(url)", logoURL: url)
            } else {
                return Organizer(name: "Org \(url)", logoURL: "fallback-url") // Evita fallos de carga
            }
        }

        await MainActor.run {
            self.organizers = preloadedImages
            self.isLoading = false
        }
    }
}

struct OrganizerCard: View {
    let organizer: Organizer
    
    var body: some View {
        VStack {
            if let url = URL(string: organizer.logoURL) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipped()
                            .cornerRadius(12)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                            .frame(width: 140, height: 140)
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .foregroundColor(.gray)
            }
            Text(organizer.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.brown.opacity(0.2))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct OrganizersView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizersView()
    }
}

extension Array {
    func concurrentMap<T>(_ transform: @escaping (Element) async -> T) async -> [T] {
        await withTaskGroup(of: (Int, T).self) { group in
            var results: [(Int, T)] = []
            results.reserveCapacity(self.count)
            
            for (index, element) in self.enumerated() {
                group.addTask {
                    return (index, await transform(element))
                }
            }
            
            for await result in group {
                results.append(result)
            }
            
            return results.sorted { $0.0 < $1.0 }.map { $0.1 }
        }
    }
}
