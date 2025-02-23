import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showCalendar = false
    @State private var events = EventService.fetchEvents()
    @State private var showFullScreenMap = false // Estado para abrir mapa en pantalla completa

    var body: some View {
        VStack {
            // Título con icono de calendario
            HStack {
                Text("CMF Tracker events")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                
            }
            .padding()
            .padding(.top, safeAreaTop()) //
            
            // Sección de eventos
            EventsSection(events: events)
                .padding(.bottom)

            // Mapa con botón de ampliar
            ZStack(alignment: .topTrailing) { // Se coloca el icono arriba a la derecha
                MapView(locationManager: locationManager)
                    .frame(height: 300)
                    .cornerRadius(20)
                    .padding()

                // Botón para ampliar el mapa
                Button(action: {
                    showFullScreenMap = true
                }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(16)
            }

            // Botón para iniciar la ruta
            StartRouteButton {
                print("Iniciando envío de ubicación al backend...")
            }
            .padding()
        }
        .sheet(isPresented: $showCalendar) {
            CalendarView(isPresented: $showCalendar, events: events) { _ in }
        }
        .fullScreenCover(isPresented: $showFullScreenMap) {
            FullScreenMapView(locationManager: locationManager)
        }
    }
    
    private func safeAreaTop() -> CGFloat {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return 0
        }
        return window.safeAreaInsets.top
    }
}
