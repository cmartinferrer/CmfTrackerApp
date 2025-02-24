import SwiftUI
import MapKit

struct RecordView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var isRecording = false

    var body: some View {
        VStack {
            Map(coordinateRegion: Binding(
                get: { locationManager.region },
                set: { _ in }
            ), showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)

            HStack {
                if isRecording {
                    Button(action: stopRecording) {
                        Text("Parar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: startRecording) {
                        Text("Empezar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color.brown)
        }
        .onAppear {
            locationManager.requestPermissionIfNeeded()
            locationManager.startUpdatingLocation() // 🔥 Activa GPS al abrir la vista
            isRecording = locationManager.isRecordingActive()
        }
        .onDisappear {
            if !isRecording {
                locationManager.stopUpdatingLocation() // 🔥 Apaga GPS si no está grabando
            }
        }
    }

    private func startRecording() {
        DispatchQueue.main.async {
            locationManager.startRecording()
            isRecording = true
        }
    }

    private func stopRecording() {
        DispatchQueue.main.async {
            locationManager.stopRecording()
            isRecording = false
        }
    }
}
