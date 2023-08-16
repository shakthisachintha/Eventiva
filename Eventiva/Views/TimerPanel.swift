//
//  TimerPanel.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct TimerPanel: View {
    var dateTime: Date
    
    @State private var currentTime = Date()
    @State private var timer: Timer?
    
    var body: some View {
        HStack {
            if yearsRemaining(from: dateTime) > 0 {
                VStack(alignment: .center) {
                    Text(String(format: "%02d", yearsRemaining(from: dateTime)))
                        .font(Font.custom("", size: 60))
                        .foregroundColor(.yellow)
                    Text("YEARS")
                        .fontWeight(.bold)
                }
                Text(":")
                    .font(Font.custom("", size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            
            if monthsRemaining(from: dateTime) > 0 {
                VStack(alignment: .center) {
                    Text(String(format: "%02d", monthsRemaining(from: dateTime)))
                        .font(Font.custom("", size: 60))
                        .foregroundColor(.yellow)
                    Text("MONTHS")
                        .fontWeight(.bold)
                }
                Text(":")
                    .font(Font.custom("", size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            
            if daysRemaining(from: dateTime) > 0 {
                VStack(alignment: .center) {
                    Text(String(format: "%02d", daysRemaining(from: dateTime)))
                        .font(Font.custom("", size: 60))
                        .foregroundColor(.yellow)
                    Text("DAYS")
                        .fontWeight(.bold)
                }
                Text(":")
                    .font(Font.custom("", size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            
            if hoursRemaining(from: dateTime) > 0 {
                VStack(alignment: .center) {
                    Text(String(format: "%02d", hoursRemaining(from: dateTime)))
                        .font(Font.custom("", size: 60))
                        .foregroundColor(.yellow)
                    Text("HOURS")
                        .fontWeight(.bold)
                }
                Text(":")
                    .font(Font.custom("", size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            
            if minutesRemaining(from: dateTime) > 0 {
                VStack(alignment: .center) {
                    Text(String(format: "%02d", minutesRemaining(from: dateTime)))
                        .font(Font.custom("", size: 60))
                        .foregroundColor(.yellow)
                    Text("MINUTES")
                        .fontWeight(.bold)
                }
                Text(":")
                    .font(Font.custom("", size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            
            if secondsRemaining(from: dateTime) > 0 {
                VStack(alignment: .center) {
                    Text(String(format: "%02d", secondsRemaining(from: dateTime)))
                        .font(Font.custom("", size: 60))
                        .foregroundColor(.yellow)
                    Text("SECONDS")
                        .fontWeight(.bold)
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = Date()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Remaining functions...
    func yearsRemaining(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: currentTime, to: date)
        return components.year ?? 0
    }
    
    func monthsRemaining(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentTime, to: date)
        let totalMonths = components.year! * 12 + components.month!
        return totalMonths % 12
    }
    
    func daysRemaining(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: currentTime, to: date)
        return components.day ?? 0
    }
    
    func hoursRemaining(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: currentTime, to: date)
        let totalHours = components.hour! + (components.minute! > 0 ? 1 : 0)
        return totalHours % 24
    }
    
    func minutesRemaining(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .second], from: currentTime, to: date)
        let totalMinutes = components.minute! + (components.second! > 0 ? 1 : 0)
        return totalMinutes % 60
    }
    
    func secondsRemaining(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: currentTime, to: date)
        let totalSeconds = (components.second ?? 0) + (components.minute ?? 0 > 0 ? 60 : 0)
        return totalSeconds % 60
    }
}

struct TimerPanel_Previews: PreviewProvider {
    static var previews: some View {
        TimerPanel(dateTime: Date())
    }
}
