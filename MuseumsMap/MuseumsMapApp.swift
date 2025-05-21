//
//  MuseumsMapApp.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI

@main
struct MuseumsMapApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var authController = AuthController()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authController)
        }
    }
}
