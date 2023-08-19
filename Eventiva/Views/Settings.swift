//
//  SettingsPageWithFormView.swift
//  swiftui-app
//
//  Created by sakun chamikara on 8/17/23.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("isDarkModeEnabled") private var darkModeEnabled = false
    @AppStorage("isSystemThemeEnabled") private var systemThemeEnabled = false
    @AppStorage("notificationEnabled") private var notificationEnabled = false
    
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Display"),
                        footer: Text("System Settings will override Dark Mode and use the current device theme")) {
                    Toggle(isOn: $darkModeEnabled, label: {
                        Text("Dark Mode")
                    })
                    .disabled(systemThemeEnabled)
                    
                    
                    Toggle(isOn: $systemThemeEnabled, label: {
                        Text("Use System Settings")
                    })
                    .disabled(darkModeEnabled) // Disable System Theme when Dark Mode is enabled
                }
                
                
                Section(header: Text("Others")) {
                    Toggle(isOn: $notificationEnabled, label: {
                        Text("Notifications")
                    })
                    .onChange(of: notificationEnabled, perform: { _ in
                        print(notificationEnabled)
                    })
                    
                    
                    Text("Clear App Data")
                        .foregroundColor(.red)
                        .onTapGesture {
                            showAlert = true
                        }
                    
                    Text("App Info")
                    
                }.alert(isPresented: $showAlert, content: {
                    Alert (title: Text("Confirmation"), message: Text("Are You sure ?"), primaryButton: .default(Text("Yes")) {
                        clearAppData()
                    }, secondaryButton: .cancel(Text("No")))
                })
                
            }
            .navigationTitle("Settings")
        }
    }
}

func clearAppData() {
    print("clear app data")
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
