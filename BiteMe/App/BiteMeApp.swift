//
//  BiteMeApp.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

@main
struct BiteMeApp: App {
    @StateObject private var savedRecipes = SavedRecipes()
    @StateObject private var menus = Menus()
    @StateObject private var auth = AuthManager()

    init() {
        URLCache.shared = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 200 * 1024 * 1024,
            diskPath: "biteme_url_cache"
        )
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if auth.isLoggedIn {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(savedRecipes)
            .environmentObject(menus)
            .environmentObject(auth)
        }
    }
}
