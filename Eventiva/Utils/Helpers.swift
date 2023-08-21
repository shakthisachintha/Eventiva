//
//  Helpers.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-16.
//

import Foundation

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
