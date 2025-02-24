import SwiftUI

struct Organizer: Identifiable {
    let id = UUID()
    let name: String
    let logoURL: String
}

struct OrganizersView: View {
    @State private var organizers: [Organizer] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(organizers) { organizer in
                    OrganizerCard(organizer: organizer)
                }
            }
            .padding(16)
        }
        .onAppear {
            loadOrganizers()
        }
    }
    
    private func loadOrganizers() {
        DispatchQueue.global(qos: .background).async {
            let data = [
                Organizer(name: "ZONA TERRA", logoURL: "https://picsum.photos/200?random=1"),
                Organizer(name: "Area 4x4", logoURL: "https://picsum.photos/200?random=2"),
                Organizer(name: "Trip and Track", logoURL: "https://picsum.photos/200?random=3"),
                Organizer(name: "Atalaya Experiences", logoURL: "https://picsum.photos/200?random=4"),
                Organizer(name: "Rodibook", logoURL: "https://picsum.photos/200?random=5"),
                Organizer(name: "Eutiches", logoURL: "https://picsum.photos/200?random=6"),
            ]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 🔹 Retraso para evitar conflicto con AsyncImage
                self.organizers = data
            }
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
