//
//  SigninView.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth


struct SigninView: View {
    @EnvironmentObject var authController: AuthController

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Увійдіть у Музеї.Пошук")
                    .font(.largeTitle)
                    .padding()

                Button {
                    Task {
                        await authController.signInWithGoogle()
                    }
                } label: {
                    HStack {
                        Image("google_auth_2")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Увійти через Google")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }

                NavigationLink(destination: MapView(), isActive: $authController.isAuthenticated) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}


#Preview {
    SigninView()
        .environmentObject(AuthController())}
