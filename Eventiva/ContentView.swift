//
//  ContentView.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-14.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel
    @State private var showAddEventSheet = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                EventList()
                
                NavigationLink {
                    AddEvent()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 56))
                        .foregroundColor(.green)
                        .padding()
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataModel())
    }
}
