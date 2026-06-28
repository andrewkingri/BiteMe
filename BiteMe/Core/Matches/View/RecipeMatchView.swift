//
//  RecipeMatchView.swift
//  BiteMe
//
//  Created by Andrew King on 10/18/25.
//

import SwiftUI

struct RecipeMatchView: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.coffee.opacity(0.85))
//                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 120) {
                VStack {
                    Image("its-a-match")
                    
                    Text("You saved recipe to your likes")
                        .foregroundStyle(Color.cream)
                }
                
                HStack {
                    Image("exampleProfileImg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(Color.cream, lineWidth: 2)
                                .shadow(radius: 4)
                            
                        }
                    
                    Image(MockData.recipes[2].imageURLs[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(Color.cream, lineWidth: 2)
                                .shadow(radius: 4)
                            
                        }
                }
                
                VStack(spacing: 16) {
                    Button("Add to List") {
                        
                    }
                    .font(.subheadline)
                    .font(Font.body.weight(.bold))
                    .foregroundStyle(Color.coffee)
                    .frame(width: 350, height: 44)
                    .background(Color.terracotta)
                    .clipShape(Capsule())
                    
                    Button("Keep Swiping") {
                        
                    }
                    .font(.subheadline)
                    .font(Font.body.weight(.bold))
                    .foregroundStyle(Color.cream)
                    .frame(width: 350, height: 44)
                    .background(.clear)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(Color.cream, lineWidth: 1)
                            .shadow(radius: 4)
                        
                    }
                }
            }
        }
    }
}

struct RecipeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeMatchView(show: .constant(true))
    }
}
