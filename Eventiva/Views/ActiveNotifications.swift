//
//  ActiveNotifications.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-21.
//

import SwiftUI
struct ActiveNotifications: View {
    @EnvironmentObject var modelData: DataModel
    @State private var scheduledNotifications: [UNNotificationRequest] = []
    
    var body: some View {
        NavigationStack{List(scheduledNotifications, id: \.identifier) { notification in
            HStack (){
                VStack(alignment: .leading) {
                    Text(notification.content.title)
                        .font(.headline)
                    Text(notification.content.body)
                        .font(.subheadline)
                    Text("\(scheduledDateAndTime(for: notification))")
                        .font(.caption)
                }
                Spacer()
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .onTapGesture {
                        modelData.removeScheduledNotification(notification)
                        loadScheduledNotifications()
                    }
            }
            
        }
        .onAppear {
            loadScheduledNotifications()
        }
        }.navigationTitle(Text("Scheduled Notifications"))
        
    }
    
    private func loadScheduledNotifications() {
        modelData.listScheduledNotifications { requests in
            scheduledNotifications = requests
        }
    }
    
    private func scheduledDateAndTime(for notification: UNNotificationRequest) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        var notificationType = ""
        if notification.identifier.contains("_15Min") {
            notificationType = "Before 15 Mins"
        } else if notification.identifier.contains("_1Day") {
            notificationType = "Before 1 Day"
        } else if notification.identifier.contains("ExactTime") {
            notificationType = "Exact Time"
        }

        if let trigger = notification.trigger as? UNCalendarNotificationTrigger {
            let scheduledDate = trigger.nextTriggerDate()
            let formattedDate = dateFormatter.string(from: scheduledDate ?? Date())
            return "\(notificationType) - \(formattedDate)"
        } else if let trigger = notification.trigger as? UNTimeIntervalNotificationTrigger {
            let scheduledDate = Date(timeIntervalSinceNow: trigger.timeInterval)
            let formattedDate = dateFormatter.string(from: scheduledDate)
            return "\(notificationType) - \(formattedDate)"
        }

        return ""
    }

}

struct ActiveNotifications_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNotifications()
    }
}
