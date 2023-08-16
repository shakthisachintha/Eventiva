//
//  Event.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-14.
//

import Foundation

struct Event: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var category: String
    var dateTime: Date
    var notifications: [Int] // number of minutes prior to event
    var isPinned: Bool
    
    var formattedDateTime: String {
            return DateFormatter.customFormatter.string(from: dateTime)
        }
}

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMMM-dd '@' hh:mm a"
        return formatter
    }()
}
