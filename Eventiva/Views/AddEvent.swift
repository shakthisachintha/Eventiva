//
//  ContentView.swift
//  Eventiva
//
//  Created by user234197 on 8/16/23.
//

import SwiftUI

struct AddEvent: View {
    @EnvironmentObject var modelData: DataModel;
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var date = Date()
    @State private var category = ""
    @State private var des = ""
    @State private var befor15min = false
    @State private var befor1day = false
    
    
    func saveEvent () {
        var notifications: [Int] = []
        
        if befor15min {
            notifications.append(15)
        }
        
        if befor1day {
            notifications.append(24 * 60) // 1 day in minutes
        }
        
        let event = Event(
            name: name,
            description: des,
            category: category,
            dateTime: date,
            notifications: notifications,
            isPinned: false
        )
        
        modelData.addEvent(event)
        // Navigate back after adding
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(header: Text("Name")){
                        TextField("Event Name", text: $name)
                    }
                    
                    Section(header: Text("Date & Time")){
                        DatePicker("Pick Date & Time",selection: $date, in: Date()...)
                    }
                    Section(header: Text("Category")){
                        TextField("Event Category", text: $category)
                    }
                    Section(header: Text("Description")){
                        TextField("Description of the event", text: $des    ).frame(width: 300,height: 100)
                        
                    }
                    Section(header: Text("Notifications")){
                        Toggle("Before 15 minites", isOn: $befor15min).disabled(!is15MinutesNotificationAvailable(for: date))
                        Toggle("Before 1 day", isOn: $befor1day).disabled(!is1DayNotificationAvailable(for: date))
                    }
                }
                Spacer() // Add spacer to push the button to the bottom
                Button(action: {
                    saveEvent()
                }, label: {
                    Text("Add Event")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                })
                
            }
            .navigationTitle(Text("Add Event"))
        }
    }
}

struct AddEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddEvent()
    }
}
