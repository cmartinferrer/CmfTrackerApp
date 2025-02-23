import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    @State private var isFullScreen = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .frame(height: isFullScreen ? UIScreen.main.bounds.height : 300)
                .edgesIgnoringSafeArea(isFullScreen ? .all : [])

            .padding()
        }
    }
}
