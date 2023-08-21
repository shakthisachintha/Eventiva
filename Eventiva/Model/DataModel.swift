import Foundation
import Combine
import UserNotifications

final class DataModel: ObservableObject {
    @Published var events: [Event] = [] {
        didSet {
            // Whenever the events array changes, update the view
            objectWillChange.send()
        }
    }
    
    init() {
        loadEvents()
    }
    
    func refreshList() {
        objectWillChange.send()
    }
    
    func addEvent(_ event: Event) {
        events.append(event)
        events.sort { $0.dateTime > $1.dateTime }
        saveEvents()
        scheduleNotifications(for: event)
    }
    
    func clearAllEvents() {
        for event in events {
            removeNotifications(for: event)
        }
        events.removeAll()
        removeAllScheduledNotifications()
        saveEvents()
    }
    
    func listPastEvents() -> [Event] {
        let now = Date()
        let pastEvents = events.filter { $0.dateTime <= now }
        let sortedPastEvents = pastEvents.sorted(by: { $0.dateTime > $1.dateTime })
        return sortedPastEvents
    }
    
    func listFutureEvents() -> [Event] {
        let now = Date()
        let futureEvents = events.filter { $0.dateTime > now }
        let sortedFutureEvents = futureEvents.sorted(by: { $0.dateTime < $1.dateTime })
        return sortedFutureEvents
    }
    
    func deleteEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
            saveEvents()
            removeNotifications(for: event)
        }
    }
    
    func updateEvent(_ updatedEvent: Event) {
        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
            let oldEvent = events[index]
            
            events[index] = updatedEvent
            events.sort { $0.dateTime > $1.dateTime }
            saveEvents()
            
            // Remove and reschedule notifications if date or notification settings change
            if oldEvent.dateTime != updatedEvent.dateTime || oldEvent.notifications != updatedEvent.notifications {
                removeNotifications(for: oldEvent)
                scheduleNotifications(for: updatedEvent)
            }
        }
    }
    
    func removeAllScheduledNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func rescheduleAllNotifications() {
        // Remove all existing notifications
        removeAllScheduledNotifications()
        let now = Date()
        // Reschedule notifications for future events
        for event in events.filter({ $0.dateTime > now }) {
            scheduleNotifications(for: event)
        }
    }
    
    func listScheduledNotifications(completionHandler: @escaping ([UNNotificationRequest]) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getPendingNotificationRequests { requests in
            completionHandler(requests)
        }
    }
    
    func event(forNotificationIdentifier identifier: String) -> Event? {
        let components = identifier.components(separatedBy: "_")
        if components.count == 2, let eventIDString = components.first,
           let eventID = UUID(uuidString: eventIDString) {
            return events.first { event in
                event.id == eventID
            }
        }
        return nil
    }
    
    func removeScheduledNotification(_ notification: UNNotificationRequest) {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.identifier])
            
            if notification.identifier.contains("_15Min") || notification.identifier.contains("_1Day") {
                if let event = event(forNotificationIdentifier: notification.identifier) {
                    var modifiedEvent = event
                    if notification.identifier.contains("_15Min") {
                        modifiedEvent.notifications.removeAll(where: { $0 == 15 })
                    }
                    if notification.identifier.contains("_1Day") {
                        modifiedEvent.notifications.removeAll(where: { $0 == 24 * 60 })
                    }
                    updateEvent(modifiedEvent)
                }
            }
        }
    
    // MARK: - Private Notification Handling
    
    private func scheduleNotifications(for event: Event) {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = event.name
        content.body = event.description
        content.sound = UNNotificationSound.default
        
        let now = Date()
        let timeIntervalUntilEvent = event.dateTime.timeIntervalSince(now)
        
        if event.notifications.contains(15) && timeIntervalUntilEvent >= 15 * 60 {
            let trigger15Min = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalUntilEvent - 15 * 60, repeats: false)
            let request15Min = UNNotificationRequest(identifier: "\(event.id)_15Min", content: content, trigger: trigger15Min)
            notificationCenter.add(request15Min)
        }
        
        if event.notifications.contains(24 * 60) && timeIntervalUntilEvent >= 24 * 60 * 60 {
            let trigger1Day = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalUntilEvent - 24 * 60 * 60, repeats: false)
            let request1Day = UNNotificationRequest(identifier: "\(event.id)_1Day", content: content, trigger: trigger1Day)
            notificationCenter.add(request1Day)
        }
        
        let triggerDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: event.dateTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(event.id)_ExactTime", content: content, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    
    private func removeNotifications(for event: Event) {
        let notificationCenter = UNUserNotificationCenter.current()
        let notificationIdentifiers = [
            "\(event.id)_15Min",
            "\(event.id)_1Day",
            "\(event.id)_ExactTime"
        ]
        notificationCenter.removePendingNotificationRequests(withIdentifiers: notificationIdentifiers)
    }
    
    // MARK: - Private Data Handling
    
    private func saveEvents() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(events) {
            UserDefaults.standard.set(encoded, forKey: "events")
        }
    }
    
    private func loadEvents() {
        if let data = UserDefaults.standard.data(forKey: "events") {
            let decoder = JSONDecoder()
            if var decoded = try? decoder.decode([Event].self, from: data) {
                // Sort the events by dateTime in descending order
                decoded.sort { $0.dateTime < $1.dateTime }
                events = decoded
            }
        }
    }
    
}
