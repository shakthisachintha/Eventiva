//
//  EventivaApp.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-14.
//

import SwiftUI

@main
struct EventivaApp: App {
    
    @StateObject private var modelData = DataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
