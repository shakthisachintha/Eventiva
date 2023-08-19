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
        
        let yearsDuration = TimeDuration(unit: "years", duration: yearsRemaining(from: dateTime, currentTime))
        timeDurations.append(yearsDuration)
        
        let monthsDuration = TimeDuration(unit: "months", duration: monthsRemaining(from: dateTime, currentTime))
        timeDurations.append(monthsDuration)
        
        let daysDuration = TimeDuration(unit: "days", duration: daysRemaining(from: dateTime, currentTime))
        timeDurations.append(daysDuration)
        
        let hoursDuration = TimeDuration(unit: "hours", duration: hoursRemaining(from: dateTime, currentTime))
        timeDurations.append(hoursDuration)
        
        let minutesDuration = TimeDuration(unit: "minutes", duration: minutesRemaining(from: dateTime, currentTime))
        timeDurations.append(minutesDuration)
        
        let secondsDuration = TimeDuration(unit: "seconds", duration: secondsRemaining(from: dateTime, currentTime))
        timeDurations.append(secondsDuration)
        
        for duration in timeDurations {
            if duration.duration > 0 && selectedTimeComponents.count < 2 {
                selectedTimeComponents.append(duration)
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
