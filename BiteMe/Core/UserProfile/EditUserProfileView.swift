//
//  EditUserProfileView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct EditUserProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ImageGridView(user: user)
                    .padding()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(Font.body.weight(.bold))
                }
            }
        }
    }
}

struct EditUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserProfileView(user: MockData.users[0])
    }
}
