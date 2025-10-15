//
//  CurrentUserProfileHeaderView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct CurrentUserProfileHeaderView: View {
    
    let user: User
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image("exampleProfileImg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .background { // frame & shadow
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 128, height: 128)
                            .shadow(radius: 10)
                    }
                
                Image(systemName: "pencil")
                    .imageScale(.small)
                    .foregroundStyle(.gray)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 32, height: 32)
                    }
                    .offset(x: -8, y: 10)
            }
            
            Text(user.firstName)
                .font(.title2)
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 240)
    }
}

struct CurrentUserProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileHeaderView(user: MockData.users[0])
    }
}
