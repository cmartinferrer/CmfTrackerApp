import SwiftUI

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        VStack {
            if let imageData = event.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
            } else {
                // Imagen por defecto en caso de error o imagen nula
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .cornerRadius(10)
            }
            
            Text(event.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            Text(event.datetime)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(event.desc)
                .padding()
            Spacer()
        }
        .navigationTitle("Detalles del Evento")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
