//
//  AuthController.swift
//  MuseumsMap
//
//  Created by Liudmyla Minkovets on 21.05.2025.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthController: ObservableObject {
    @Published var isAuthenticated = false
    
    func signInWithGoogle() async {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("❌ clientID is missing")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = await windowScene.windows.first?.rootViewController else {
            print("❌ No rootViewController")
            return
        }

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

            guard let idToken = result.user.idToken?.tokenString else {
                print("❌ Не вдалося отримати ID Token")
                return
            }
            let accessToken = result.user.accessToken.tokenString


            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: accessToken
            )

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("❌ Firebase login error: \(error.localizedDescription)")
                } else {
                    print("✅ Firebase login success")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                }
            }

        } catch {
            print("❌ Google Sign-In error:", error.localizedDescription)
        }
    }

}


