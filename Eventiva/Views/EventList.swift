//
//  EventList.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import SwiftUI
import Combine

struct EventList: View {
    @EnvironmentObject var modelData: DataModel;
    @State private var selectedFilters: Set<FilterOption> = []
    @State private var rawData: [Event] = []
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var selectedCategories: Set<String> = []
    
    
    enum FilterOption: String, CaseIterable, Hashable {
        case next24Hours = "24 Hours"
        case thisMonth = "This Month"
        case nextMonth = "Next Month"
        case party = "party"
        case meeting = "meeting"
        case health = "health"
        case entertainment = "entertainment"
        case family = "family"
        case other = "other"
    }
    
    var filteredEvents: [Event] {
        var events = rawData
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
                    
                case .party, .meeting, .health, .entertainment, .family, .other:
                    let category = filter.rawValue
                    events.append(contentsOf: rawData.filter { $0.category == category })
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
        case .party, .meeting, .health, .entertainment, .family, .other:
            // Count events based on selected category
            let category = option.rawValue
            return rawData.filter { $0.category == category }.count
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Filter buttons
                ScrollView(.horizontal, showsIndicators: false){HStack {
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
                                Text(option.rawValue.capitalized).foregroundColor(isSelected ? Color.black : Color.white).font(.footnote).fontWeight(.bold)
                                
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
                    }
                }}
                ScrollView {
                    ForEach(Array(filteredEvents.enumerated()), id: \.element.id) { index, event in
                        NavigationLink(destination: EditEvent(event: event)) {
                            EventCard(event: event, index: index)
                        }
                    }
                }
            }.onAppear {
                rawData = modelData.listFutureEvents()
                // Listen for changes in the events array
                modelData.objectWillChange
                    .sink { _ in
                        rawData = modelData.listFutureEvents()
                    }
                    .store(in: &cancellables)
            }
        }
    }
    
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList().environmentObject(DataModel())
    }
}
