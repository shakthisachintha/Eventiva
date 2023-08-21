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
            HStack(alignment:.center) {
                NavigationLink(destination: Settings()) {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("Your Events")
                Spacer()
                NavigationLink(destination: ActiveNotifications()) {
                    Image(systemName: "bell.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
                
           
            }.padding(.bottom, 10)
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
