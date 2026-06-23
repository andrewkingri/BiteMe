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

    var body: some Scene {
        WindowGroup {
//            ContentView()
            MainTabView()
                .environmentObject(savedRecipes)
        }
    }
}
