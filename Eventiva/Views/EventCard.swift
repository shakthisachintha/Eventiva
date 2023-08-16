//
//  EventCard.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct EventCard: View {
    var event: Event
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text(event.name).font(.title2)
                    Spacer()
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image(systemName: "arrowshape.turn.up.right.circle.fill")
                    }
                }
                HStack{
                    Text(event.description).font(.body).lineLimit(1).truncationMode(.tail)
                    Spacer()
                }
                TimerPanel(dateTime: event.dateTime)
                HStack{
                    Text(event.formattedDateTime).font(.callout)
                    Spacer()
                }
            }.padding()
        }.background(
            getGradient(event.id)
        ).cornerRadius(5)
    }
}

struct EventCard_Previews: PreviewProvider {
    static var events = DataModel().events
    
    static var previews: some View {
        EventCard(event: events[2])
    }
}
