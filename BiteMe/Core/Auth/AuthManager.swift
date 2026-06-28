//
//  AuthManager.swift
//  BiteMe
//
//  Created by Andrew King on 6/27/26.
//

import Foundation

@MainActor
class AuthManager: ObservableObject {
    @Published private(set) var isLoggedIn: Bool
    @Published private(set) var email: String?

    private let defaults = UserDefaults.standard
    private let loggedInKey = "auth.isLoggedIn"
    private let emailKey = "auth.email"

    init() {
        isLoggedIn = defaults.bool(forKey: loggedInKey)
        email = defaults.string(forKey: emailKey)
    }

    /// Signs the user in. This is a simple local sign-in with no backend.
    func logIn(email: String) {
        self.email = email
        isLoggedIn = true
        defaults.set(true, forKey: loggedInKey)
        defaults.set(email, forKey: emailKey)
    }

    func logOut() {
        email = nil
        isLoggedIn = false
        defaults.set(false, forKey: loggedInKey)
        defaults.removeObject(forKey: emailKey)
    }
}
