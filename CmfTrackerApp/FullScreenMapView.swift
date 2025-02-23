import SwiftUI
import MapKit

struct FullScreenMapView: View {
    @ObservedObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: .constant(locationManager.region), showsUserLocation: true)
                .ignoresSafeArea()

            // Botón para cerrar el mapa en pantalla completa
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding(20)
        }
    }
}
