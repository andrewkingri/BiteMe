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
            
            Text("search view")
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
            
            Text("saved view")
                .tabItem { Image(systemName: "heart") }
                .tag(2)
            
            CurrentUserProfileView(user: MockData.users[0])
                .tabItem { Image(systemName: "person") }
                .tag(3)
        }
        .tint(.primary)
        .accentColor(.red)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
