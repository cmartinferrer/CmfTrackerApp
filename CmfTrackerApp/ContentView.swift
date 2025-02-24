import SwiftUI

enum TabItem: String, CaseIterable {
    case home = "Inicio"
    case organizers = "Organizadores"
    case record = "Grabar"
    case myEvents = "Mis eventos"
    case myActivity = "Mi actividad"
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .organizers: return "person.3.fill"
        case .record: return "record.circle.fill"
        case .myEvents: return "calendar"
        case .myActivity: return "chart.bar.fill"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: TabItem = .myEvents
    
    var body: some View {
        VStack(spacing: 0) {
            // Franja superior marrón (solo para la barra de estado y la isla flotante)
            Color.brown
                .frame(height: safeAreaTop())
                .ignoresSafeArea()
            
            // Contenido dinámico
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .organizers:
                    OrganizersView()
                case .record:
                    RecordView()
                case .myEvents:
                    MyEventsView()
                case .myActivity:
                    MyActivityView()
                }
            }
            .frame(maxHeight: .infinity)
            
            // Menú inferior
            HStack {
                ForEach(TabItem.allCases, id: \.self) { tab in
                    VStack {
                        Image(systemName: tab.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                        Text(tab.rawValue)
                            .font(.caption)
                    }
                    .foregroundColor(selectedTab == tab ? .white : Color(red: 0.9, green: 0.8, blue: 0.7))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .onTapGesture {
                        selectedTab = tab
                    }
                }
            }
            .frame(height: 60)
            .background(Color.brown.ignoresSafeArea(edges: .bottom))
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
