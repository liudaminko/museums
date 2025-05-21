//
//  LaunchScreenView.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var appDelegate: AppDelegate

    var body: some View {
        if appDelegate.showMainView {
            MapView()
        } else {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Image("AppIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Museums Map")
                        .font(.title)
                        .bold()
                }
            }
        }
    }
}
#Preview {
    LaunchScreenView()
}
