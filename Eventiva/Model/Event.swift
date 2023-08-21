//
//  Event.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-14.
//

import Foundation

struct TimeDuration {
    var unit: String
    var duration: Int
}

enum Category: String, CaseIterable {
    case party = "party"
    case meeting = "meeting"
    case health = "health"
    case entertainment = "entertainment"
    case family = "family"
    case other = "other"
}

struct Event: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var category: String
    var dateTime: Date
    var notifications: [Int] // number of minutes prior to event
    var isPinned: Bool
    
    // New initializer without ID, automatically generates an ID
    init(name: String, description: String, category: String, dateTime: Date, notifications: [Int], isPinned: Bool) {
        self.name = name
        self.description = description
        self.category = category
        self.dateTime = dateTime
        self.notifications = notifications
        self.isPinned = isPinned
    }
    
    // New initializer without ID, automatically generates an ID
    init(id: UUID,name: String, description: String, category: String, dateTime: Date, notifications: [Int], isPinned: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.dateTime = dateTime
        self.notifications = notifications
        self.isPinned = isPinned
    }
    
    var formattedDateTime: String {
        return DateFormatter.customFormatter.string(from: dateTime)
    }
    
    func getActiveTimeCoponents(current: Date)->[TimeDuration] {
        let currentTime = Date()
        var timeDurations: [TimeDuration] = []
        var selectedTimeComponents: [TimeDuration] = []
        
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime, to: dateTime)
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        let yearsDuration = TimeDuration(unit: "years", duration: years)
        timeDurations.append(yearsDuration)
        
        let monthsDuration = TimeDuration(unit: "months", duration: months)
        timeDurations.append(monthsDuration)
        
        let daysDuration = TimeDuration(unit: "days", duration: days)
        timeDurations.append(daysDuration)
        
        let hoursDuration = TimeDuration(unit: "hours", duration: hours)
        timeDurations.append(hoursDuration)
        
        let minutesDuration = TimeDuration(unit: "minutes", duration: minutes)
        timeDurations.append(minutesDuration)
        
        let secondsDuration = TimeDuration(unit: "seconds", duration: seconds)
        timeDurations.append(secondsDuration)
        
        for duration in timeDurations {
            if duration.duration > 0 && selectedTimeComponents.count < 2 {
                selectedTimeComponents.append(duration)
            }
        }
        if (selectedTimeComponents.count == 1) {
            let currentElemnet = selectedTimeComponents[0]
            var prevElement: TimeDuration = TimeDuration(unit: "hours", duration: hours)
            
            if (currentElemnet.unit == "minutes") {
                prevElement = TimeDuration(unit: "seconds", duration: 0)
                selectedTimeComponents.append(prevElement)
            }
            
            if (currentElemnet.unit == "seconds") {
                prevElement = TimeDuration(unit: "minutes", duration: 0)
                selectedTimeComponents.insert(prevElement, at: 0)
            }
        }
        
        return selectedTimeComponents;
    }
}

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMMM-dd '@' hh:mm a"
        return formatter
    }()
}
