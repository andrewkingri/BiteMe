//
//  CurrentUserProfileView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @State private var showEditProfile = false
    let user: User

    init(user: User) {
        self.user = user
        UITableView.appearance().backgroundColor = UIColor(Color.cream)
    }

    var body: some View {
        NavigationView { // NavigationStack
            List {
                // header view
                CurrentUserProfileHeaderView(user: user)
                    .onTapGesture { showEditProfile.toggle() }
                
                // account info view
                Section("Section One") {
                    HStack {
                        Text("Name")
                        
                        Spacer()
                        
                        Text(user.firstName)
                    }
                    
                    HStack {
                        Text("Username")
                        
                        Spacer()
                        
                        Text("@\(user.username)")
                    }
                }
                
                // legal view
                // this is required for every app on the app store
                // user must agree to ToS when joining
                Section("Section Two") {
                    Text("Terms of Service")
                }
                
                // logout
                Section {
                    Button("Logout") {
                        
                    }
                    .foregroundStyle(Color.tomato)
                }
                
                // delete account
                Section {
                    Button("Delete Account") {
                        
                    }
                    .foregroundStyle(Color.tomato)
                }
                
            }
            .background(Color.cream)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showEditProfile) {
                EditUserProfileView(user: user)
            }
        }
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: MockData.users[0])
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
