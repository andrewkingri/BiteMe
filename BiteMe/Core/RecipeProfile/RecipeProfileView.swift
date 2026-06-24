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
                
//                Text(recipe.dietTags)
//                    .font(.title2)
//                    .fontWeight(.ultraLight)
                
                Spacer()
                
                Button {
                    print("Hello world")
                    dismiss()
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .imageScale(.large)
                        .font(Font.body.weight(.bold))
                        .foregroundStyle(Color.mustard)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        AsyncImage(url: URL(string: recipe.imageURLs[currentImageIndex])) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.coffee.opacity(0.1)
                        }
                        .frame(width: SizeConstants.cardWidth,
                               height: SizeConstants.cardHeight)
                        .clipped()
                        .overlay {
                            ImageScrollingOverlay(currentImageIndex: $currentImageIndex,
                                                  imageCount: recipe.imageURLs.count)
                        }
                        
                        CardImageIndicatorView(currentImageIndex: currentImageIndex,
                                               imageCount: recipe.imageURLs.count)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .fontWeight(.semibold)

                        if recipe.ingredients.isEmpty {
                            Text("No ingredients listed.")
                                .italic()
                                .foregroundStyle(Color.coffee.opacity(0.6))
                        } else {
                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { _, ingredient in
                                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                                        Text("•")
                                        if !ingredient.measure.isEmpty {
                                            Text(ingredient.measure)
                                                .fontWeight(.semibold)
                                        }
                                        Text(ingredient.name)
                                        Spacer(minLength: 0)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.coffee.opacity(0.08))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instructions")
                            .fontWeight(.semibold)

                        if recipe.instructions.isEmpty {
                            Text("No instructions available for this recipe.")
                                .italic()
                                .foregroundStyle(Color.coffee.opacity(0.6))
                        } else {
                            Text(recipe.instructions)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.coffee.opacity(0.08))
                    .font(.subheadline)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Essentials")
//                        .fontWeight(.semibold)
//                    
//                    HStack {
//                        Image(systemName: "person")
//                                                
//                        Text("Woman")
//                        
//                        Spacer()
//                    }
//                    
//                    HStack {
//                        Image(systemName: "arrow.down.forward.and.arrow.up.backward.circle")
//                                                
//                        Text("Straight")
//                        
//                        Spacer()
//                    }
//                    
//                    HStack {
//                        Image(systemName: "book")
//                                                
//                        Text("Actress")
//                        
//                        Spacer()
//                    }
//                }
//                .padding()
//                .background(Color.coffee.opacity(0.08))
//                .font(.subheadline)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .background(Color.cream)
        .foregroundStyle(Color.coffee)
    }
}

struct RecipeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeProfileView(recipe: MockData.recipes[0])
    }
}
