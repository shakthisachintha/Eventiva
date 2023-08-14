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
    var notifcations: [Int] // number of minutes prior to event
    var isPinned: Bool
}
