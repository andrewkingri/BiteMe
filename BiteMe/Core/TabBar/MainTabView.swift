//
//  MainTabBar.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CardStackView()
                .tabItem { Image(systemName: "fork.knife") }
                .tag(0)
            
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
            
            SavedRecipesView()
                .tabItem { Image(systemName: "heart") }
                .tag(2)
            
            CurrentUserProfileView(user: MockData.users[0])
                .tabItem { Image(systemName: "person") }
                .tag(3)
        }
        .tint(Color.terracotta)
        .background(Color.cream)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(SavedRecipes())
            .environmentObject(Menus())
    }
}
