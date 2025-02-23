//
//  EventsView.swift
//  CmfTrackerApp
//
//  Created by Cristian Martin Ferrer on 23/2/25.
//

import SwiftUI

struct EventsView: View {
    let events: [Event]
    @Binding var selectedEvent: Event?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(events) { event in
                    VStack {
                        Image(event.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                selectedEvent = event
                            }
                        
                        Text(event.title)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 5)
                }
            }
            .padding(.horizontal)
        }
    }
}
