import SwiftUI

struct EventsSection: View {
    @State private var showCalendar = false
    @State private var selectedEvent: Event? = nil
    let events: [Event]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Eventos")
                    .font(.headline)
                Spacer()
                Button(action: {
                    showCalendar = true
                }) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(events) { event in
                        EventCard(event: event)
                            .onTapGesture {
                                selectedEvent = event
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showCalendar) {
            CalendarView(isPresented: $showCalendar, events: events) { event in
                selectedEvent = event
            }
        }
        .sheet(item: $selectedEvent) { event in
            EventDetailView(event: event)
        }
    }
}
