//
//  RootView.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var appDelegate: AppDelegate

    @State private var showLaunchScreen = true

    var body: some View {
        ZStack {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                if authController.isAuthenticated {
                    MapView()
                } else {
                    SigninView()
                }
            }
        }
    }
}

