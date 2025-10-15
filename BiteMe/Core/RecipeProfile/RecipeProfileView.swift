//
//  RecipeProfileView.swift
//  BiteMe
//
//  Created by Andrew King on 10/14/25.
//

import SwiftUI

struct RecipeProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var currentImageIndex = 0
    
    let recipe: Recipe
    
    var body: some View {
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(recipe.dietTags)
                    .font(.title2)
                    .fontWeight(.ultraLight)
                
                Spacer()
                
                Button {
                    print("Hello world")
                    dismiss()
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .imageScale(.large)
                        .font(Font.body.weight(.bold))
                        .foregroundStyle(.pink)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        Image(recipe.imageURLs[currentImageIndex])
                            .resizable()
                            .scaledToFill()
                            .frame(width: SizeConstants.cardWidth,
                                   height: SizeConstants.cardHeight)
                            .overlay {
                                ImageScrollingOverlay(currentImageIndex: $currentImageIndex,
                                                      imageCount: recipe.imageURLs.count)
                            }
                        
                        CardImageIndicatorView(currentImageIndex: currentImageIndex,
                                               imageCount: recipe.imageURLs.count)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .fontWeight(.semibold)
                        
//                        if let ingredients = recipe.ingredients {
//                            Text(ingredients)
//                        }
                        
                        Text("some random text in here description")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Essentials")
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "person")
                                                
                        Text("Woman")
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "arrow.down.forward.and.arrow.up.backward.circle")
                                                
                        Text("Straight")
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "book")
                                                
                        Text("Actress")
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .font(.subheadline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

struct RecipeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeProfileView(recipe: MockData.recipes[0])
    }
}
