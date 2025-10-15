//
//  CurrentUserProfileView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    var body: some View {
        NavigationView { // NavigationStack
            List {
                // header view
                CurrentUserProfileHeaderView(user: user)
                
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
                    .foregroundStyle(.red)
                }
                
                // delete account
                Section {
                    Button("Delete Account") {
                        
                    }
                    .foregroundStyle(.red)
                }
                
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
