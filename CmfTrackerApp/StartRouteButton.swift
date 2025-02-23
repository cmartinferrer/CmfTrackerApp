import SwiftUI

struct StartRouteButton: View {
    var onStart: () -> Void

    var body: some View {
        Button(action: {
            onStart()
        }) {
            Text("Empezar Ruta")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
        }
        .padding()
    }
}
