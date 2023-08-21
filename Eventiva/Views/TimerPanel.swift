//
//  TimerPanel.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct TimerPanel: View {
    var event: Event
    @EnvironmentObject var modelData: DataModel;
    
    @State private var currentTime = Date()
    @State private var timer: Timer?
    @State private var selectedComponentOne = TimeDuration(unit: "minutes", duration: 0)
    @State private var selectedComponentTwo = TimeDuration(unit: "seconds", duration: 0)
    
    
    var body: some View {
        HStack {
            
            VStack(alignment: .center) {
                Text(String(format: "%02d", selectedComponentOne.duration))
                    .font(Font.custom("", size: 60))
                    .foregroundColor(.yellow)
                Text(selectedComponentOne.unit.uppercased())
                    .fontWeight(.bold).foregroundColor(.white)
            }
            
            Text(":")
                .font(Font.custom("", size: 50))
                .foregroundColor(.yellow)
                .padding(.bottom)
            
            VStack(alignment: .center) {
                Text(String(format: "%02d", selectedComponentTwo.duration))
                    .font(Font.custom("", size: 60))
                    .foregroundColor(.yellow)
                Text(selectedComponentTwo.unit.uppercased())
                    .fontWeight(.bold).foregroundColor(.white)
            }
            
        }
        .onAppear {
            let times = event.getActiveTimeCoponents(current: Date())
            if (times.count >= 2) {
                selectedComponentOne = times[0]
                selectedComponentTwo = times[1]
            }
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .id(event.dateTime.hashValue)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = Date()
            
            let times = event.getActiveTimeCoponents(current: Date())
            if (times.count >= 2 ) {
                selectedComponentOne = times[0]
                selectedComponentTwo = times[1]
            }
            if (times.count == 0) {
                selectedComponentOne = TimeDuration(unit: "minutes", duration: 0)
                selectedComponentTwo = TimeDuration(unit: "seconds", duration: 0)
                modelData.refreshList()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


struct TimerPanel_Previews: PreviewProvider {
    static var events = DataModel().events
    
    static var previews: some View {
        TimerPanel(event: events[0])
    }
}
