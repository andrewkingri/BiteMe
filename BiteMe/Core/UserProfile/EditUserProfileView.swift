//
//  EditUserProfileView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct EditUserProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var bio = "this is where my lil bio would go"
    @State private var occupation = "my occupation"
    
    let user: User
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ImageGridView(user: user)
                    .padding()
                    .foregroundStyle(Color.coffee)
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("ABOUT ME")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)

                        // todo make this a custom TextEditor with a built in placeholder
                        // (google "swift TextEditor placeholder ios 15")
                        TextField("Add your bio", text: $bio)
                            .padding()
                            .frame(height: 64, alignment: .top)
                            .background(Color.coffee.opacity(0.08))
                            .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("OCCUPATION")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Image(systemName: "book")
                            
                            Text("Occupation")
                            
                            Spacer()
                            
                            Text(occupation)
                                .font(.footnote)
                        }
                        .padding()
                        .background(Color.coffee.opacity(0.08))
                        .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("GENDER")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Text("Man")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                        .padding()
                        .background(Color.coffee.opacity(0.08))
                        .font(.subheadline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("SEXUAL ORIENTATION")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        HStack {
                            Text("Straight")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                        .padding()
                        .background(Color.coffee.opacity(0.08))
                        .font(.subheadline)
                    }
                }
                .foregroundStyle(Color.coffee)
            }
            .background(Color.cream)
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
