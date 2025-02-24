//
//  CmfTrackerAppApp.swift
//  CmfTrackerApp
//
//  Created by Cristian Martin Ferrer on 23/2/25.
//

import SwiftUI

@main
struct CmfTrackerAppApp: App {
    @StateObject private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationManager) // 🔥 Se comparte en toda la app
        }
    }
}
