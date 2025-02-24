//
//  HomeView.swift
//  CmfTrackerApp
//
//  Created by Cristian Martin Ferrer on 24/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("CMF Tracker")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            Text("Tu aplicación para seguimiento de rutas y eventos.")
                .font(.body)
                .padding()
        }
    }
}
