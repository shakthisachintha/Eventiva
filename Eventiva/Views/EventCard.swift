//
//  EventCard.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct EventCard: View {
    var event: Event
    var index: Int? // Optional index parameter
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text(event.name).font(.title2).foregroundColor(.white).fontWeight(.medium)
                    Spacer()
                    ShareLink(item:"", subject: Text(event.name), message: Text(event.name+"\n"+event.description+"\n "+event.formattedDateTime)) {
                        Image(systemName: "arrowshape.turn.up.right.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.gray)
                    }
                }
                HStack{
                    Text(event.description).font(.body).lineLimit(1).truncationMode(.tail).foregroundColor(.white)
                    Spacer()
                }
                TimerPanel(event: event)
                HStack{
                    Text(event.formattedDateTime).font(.callout).foregroundColor(.white)
                    Spacer()
                }
            }.padding()
        }.background(
            getGradient(index ?? 1)
        ).cornerRadius(5)
    }
    
}

struct EventCard_Previews: PreviewProvider {
    static var events = DataModel().events
    
    static var previews: some View {
        EventCard(event: events[3])
    }
}
