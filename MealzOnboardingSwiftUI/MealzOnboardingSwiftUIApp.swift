//
//  MealzOnboardingSwiftUIApp.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

// TODO: 1. Import Mealz Repositories
import mealzcore
import MealziOSSDK

@main
struct MealzOnboardingSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // init Mealz
        let _ = MealzManager.sharedInstance
        return true
    }
}

// TODO: 2. Create MealzManager file
