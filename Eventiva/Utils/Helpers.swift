//
//  Helpers.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-16.
//

import Foundation

// Timer Functions
func yearsRemaining(from date: Date, _ currentTime: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: currentTime, to: date)
    return max(components.year ?? 0, 0)
}

func monthsRemaining(from date: Date, _ currentTime: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: currentTime, to: date)
    let totalMonths = components.year! * 12 + components.month!
    return max((totalMonths % 12) - 1, 0)
}

func daysRemaining(from date: Date, _ currentTime: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: currentTime, to: date)
    return max(components.day ?? 0, 0)
}

func hoursRemaining(from date: Date, _ currentTime: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: currentTime, to: date)
    let totalHours = components.hour! + (components.minute! > 0 ? 1 : 0)
    return max((totalHours % 24) - 1, 0)
}

func minutesRemaining(from date: Date, _ currentTime: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.minute, .second], from: currentTime, to: date)
    let totalMinutes = components.minute! + (components.second! > 0 ? 1 : 0)
    return max((totalMinutes % 60) - 1, 0)
}

func secondsRemaining(from date: Date, _ currentTime: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.second], from: currentTime, to: date)
    let totalSeconds = (components.second ?? 0) + (components.minute ?? 0 > 0 ? 60 : 0)
    return max((totalSeconds % 60) - 1, 0)
}

func is15MinutesNotificationAvailable(for date: Date) -> Bool {
       let now = Date()
       let timeIntervalUntilEvent = date.timeIntervalSince(now)
       return timeIntervalUntilEvent >= ((15 * 60) - 2) // At least 15 minutes in seconds
   }
   
func is1DayNotificationAvailable(for date: Date) -> Bool {
       let now = Date()
       let timeIntervalUntilEvent = date.timeIntervalSince(now)
       return timeIntervalUntilEvent >= ((24 * 60 * 60) - 2) // At least 1 day in seconds
   }
