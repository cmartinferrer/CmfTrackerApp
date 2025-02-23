import SwiftUI

struct CalendarView: View {
    @Binding var isPresented: Bool
    let events: [Event]
    let onEventSelected: (Event) -> Void

    var body: some View {
        NavigationView {
            VStack {
                List(events) { event in
                    Button(action: {
                        onEventSelected(event)
                        isPresented = false
                    }) {
                        HStack {
                            if let imageData = event.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                // Imagen por defecto en caso de error o imagen nula
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.datetime)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(5)
                    }
                }
            }
            .navigationTitle("Eventos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
