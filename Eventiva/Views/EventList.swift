//
//  EventList.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject var modelData: DataModel;
    
    var filteredEvents: [Event] {
        return modelData.events
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Text("Filter Panel")
                }
                ForEach(filteredEvents) {
                    event in EventCard(event: event)
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList().environmentObject(DataModel())
    }
}
