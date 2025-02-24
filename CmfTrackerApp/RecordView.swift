import SwiftUI
import MapKit

struct RecordView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var isRecording = false // 🔥 Ahora el estado lo gestiona la vista

    var body: some View {
        VStack {
            Map(coordinateRegion: Binding(
                get: { locationManager.region },
                set: { _ in } // Bloqueamos el set para evitar conflictos de SwiftUI
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
            isRecording = locationManager.isRecordingActive() // 🔥 Refresca el estado al entrar
        }
    }

    private func startRecording() {
        DispatchQueue.main.async {
            locationManager.startRecording()
            isRecording = true
            print("▶️ Botón Empezar presionado")
        }
    }

    private func stopRecording() {
        DispatchQueue.main.async {
            locationManager.stopRecording()
            isRecording = false
            print("⏹️ Botón Parar presionado")
        }
    }
}
