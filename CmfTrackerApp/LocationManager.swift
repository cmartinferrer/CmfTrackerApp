import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published private(set) var region: MKCoordinateRegion
    @Published private(set) var lastLocation: CLLocation?

    private var timer: Timer?
    private var isRecording = false // 🔥 Variable local para gestionar el estado

    override init() {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Ubicación inicial
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermissionIfNeeded() {
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.lastLocation = location
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }

    func startRecording() {
        guard !isRecording else { return } // Evita que se inicie más de una vez
        isRecording = true
        print("🔴 Iniciando grabación...")

        startUpdatingLocation() // 🔥 Activa GPS solo cuando grabamos

        stopTimer() // Evita timers duplicados
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let location = self.lastLocation {
                    print("📍 Enviando ubicación al backend: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                }
            }
        }
    }

    func stopRecording() {
        guard isRecording else { return }
        isRecording = false
        print("🛑 Deteniendo grabación...")
        stopTimer()
        stopUpdatingLocation() // 🔥 Apaga GPS al terminar
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        print("✅ Timer detenido correctamente.")
    }

    func isRecordingActive() -> Bool {
        return isRecording
    }
}
