//
//  EventList.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject var modelData: DataModel;
    @State private var selectedFilters: Set<FilterOption> = []
    @State private var rawData: [Event] = []
    
    enum FilterOption: String, CaseIterable, Hashable {
        case next24Hours = "24 Hours"
        case thisMonth = "This Month"
        case nextMonth = "Next Month"
    }
    
    var filteredEvents: [Event] {
        var events = modelData.listFutureEvents()
        
        if !selectedFilters.isEmpty {
            events.removeAll()
            for filter in selectedFilters {
                switch filter {
                case .next24Hours:
                    let next24Hours = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
                    events.append(contentsOf: rawData.filter { $0.dateTime < next24Hours })
                case .thisMonth:
                    let currentDate = Date()
                    let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate))!
                    let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
                    events.append(contentsOf: rawData.filter { $0.dateTime >= startOfMonth && $0.dateTime <= endOfMonth })
                case .nextMonth:
                    let currentDate = Date()
                    let startOfNextMonth = Calendar.current.date(byAdding: DateComponents(month: 1), to: currentDate)!
                    let endOfNextMonth = Calendar.current.date(byAdding: DateComponents(month: 2, day: -1), to: startOfNextMonth)!
                    events.append(contentsOf: rawData.filter { $0.dateTime >= startOfNextMonth && $0.dateTime <= endOfNextMonth })
                }
            }
        }
        
        return events
    }
    
    
    func countForFilter(option: FilterOption) -> Int {
        switch option {
        case .next24Hours:
            let next24Hours = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            return rawData.filter { $0.dateTime < next24Hours }.count
        case .thisMonth:
            let currentDate = Date()
            let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate))!
            let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
            return rawData.filter { $0.dateTime >= startOfMonth && $0.dateTime <= endOfMonth }.count
        case .nextMonth:
            let currentDate = Date()
            let startOfNextMonth = Calendar.current.date(byAdding: DateComponents(month: 1), to: currentDate)!
            let endOfNextMonth = Calendar.current.date(byAdding: DateComponents(month: 2, day: -1), to: startOfNextMonth)!
            return rawData.filter { $0.dateTime >= startOfNextMonth && $0.dateTime <= endOfNextMonth }.count
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment:.center) {
                    NavigationLink(destination: Settings()) {
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("Your Events")
                    Spacer()
                    Button(action: {
                        print("notifications clicked")
                    }) {
                        Image(systemName: "bell.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                    }
                }.padding(.bottom, 10)
                // Filter buttons
                HStack {
                    ForEach(FilterOption.allCases, id: \.self) { option in
                        let isSelected = selectedFilters.contains(option)
                        let count = countForFilter(option: option)
                        
                        Button(action: {
                            if isSelected {
                                selectedFilters.remove(option)
                            } else {
                                selectedFilters.insert(option)
                            }
                        }) {
                            HStack {
                                Text(option.rawValue).foregroundColor(isSelected ? Color.black : Color.white).font(.footnote).fontWeight(.bold)
                                
                                Text("\(count)")
                                    .foregroundColor(isSelected ? Color.white : Color.black).font(.footnote)
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .background(
                                        Circle()
                                            .fill(isSelected ? Color.black : Color.secondary)
                                            .padding(2)
                                    )
                                
                                
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(isSelected ? Color.white : Color.gray)
                            .cornerRadius(5)
                        }
                        
                        if option != FilterOption.allCases.last { // Exclude spacer after the last button
                            Spacer()
                        }
                    }
                }
                ScrollView {
                    ForEach(filteredEvents) { event in
                        NavigationLink(destination: EditEvent(event: event)) {
                            EventCard(event: event)
                        }
                    }
                }
            }.onAppear {
                rawData = modelData.listFutureEvents()
            }
        }
    }
        
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList().environmentObject(DataModel())
    }
}
