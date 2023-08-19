//
//  EventivaApp.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-14.
//

import SwiftUI
import UserNotifications

@main
struct EventivaApp: App {
    
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    @AppStorage("isSystemThemeEnabled") private var systemThemeEnabled = false
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @StateObject private var modelData = DataModel()
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    func getTheme() -> ColorScheme? {
        if systemThemeEnabled {
            return .none // Let the system handle the color scheme
        } else {
            return isDarkModeEnabled ? .dark : .light
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData).preferredColorScheme(getTheme()).onAppear {
                requestNotificationPermission()
            }
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            // Handle authorization response if needed
        }
        return true
    }

    // Handle notifications received while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Display an alert or update UI to notify the user of the incoming notification
        completionHandler([.alert, .sound, .badge])
    }
}
