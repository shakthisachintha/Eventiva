//
//  EditEvent.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct EditEvent: View {
    var event: Event
    
    @EnvironmentObject var modelData: DataModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingConfirmationAlert = false
    
    @State private var name = ""
    @State private var date = Date()
    @State private var category = ""
    @State private var des = ""
    @State private var befor15min = false
    @State private var befor1day = false
    
    func updateEvent() {
        let updatedEvent = Event(
            id: event.id,
            name: name,
            description: des,
            category: category,
            dateTime: date,
            notifications: [befor15min ? 15 : 0, befor1day ? 24 * 60 : 0],
            isPinned: event.isPinned
        )
        modelData.updateEvent(updatedEvent)
        presentationMode.wrappedValue.dismiss() // Navigate back after updating
    }
    
    var body: some View {
        NavigationStack() {
            VStack {
                Form {
                    Section(header: Text("Name")) {
                        TextField("Event Name", text: $name)
                    }
                    
                    Section(header: Text("Date & Time")) {
                        DatePicker("Pick Date & Time", selection: $date, in: Date()...).onChange(of: date) { newDate in
                            befor15min = is15MinutesNotificationAvailable(for: newDate) && event.notifications.contains(15)
                            befor1day = is1DayNotificationAvailable(for: newDate) && event.notifications.contains(24 * 60)
                        }
                    }
                    Section(header: Text("Category")) {
                        TextField("Event Category", text: $category)
                    }
                    Section(header: Text("Description")) {
                        TextField("Description of the event", text: $des).frame(width: 300, height: 100)
                    }
                    Section(header: Text("Notifications")) {
                        Toggle("Before 15 minutes", isOn: $befor15min).disabled(!is15MinutesNotificationAvailable(for: date))
                            .onAppear {
                                befor15min = event.notifications.contains(15)
                            }
                        Toggle("Before 1 day", isOn: $befor1day).disabled(!is1DayNotificationAvailable(for: date))
                            .onAppear {
                                befor1day = event.notifications.contains(24 * 60)
                            }
                    }
                }
                
                Spacer() // Add spacer to push the button to the bottom
                Button(action: {
                    updateEvent()
                }, label: {
                    Text("Update Event")
                        .foregroundColor(.black)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.yellow)
                        .cornerRadius(10)
                        .padding()
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingConfirmationAlert = true
                    }) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                    }
                }
            }.navigationTitle(Text("Edit Event"))
                .alert(isPresented: $showingConfirmationAlert) {
                    Alert(
                        title: Text("Delete Event"),
                        message: Text("Are you sure you want to delete this event?"),
                        primaryButton: .destructive(Text("Delete")) {
                            modelData.deleteEvent(event)
                            presentationMode.wrappedValue.dismiss() // Navigate back after deletion
                        },
                        secondaryButton: .cancel()
                    )
                }
        }
        .onAppear {
            name = event.name
            des = event.description
            date = event.dateTime
        }
    }
}

struct EditEvent_Previews: PreviewProvider {
    static var events = DataModel().listFutureEvents()
    
    static var previews: some View {
        EditEvent(event: events[0]).environmentObject(DataModel())
    }
}
