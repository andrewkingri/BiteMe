//
//  SavedRecipesView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject private var store: SavedRecipes
    @State private var presentedRecipe: Recipe?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Saved")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.coffee)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            if store.recipes.isEmpty {
                Spacer()
                emptyState
                    .frame(maxWidth: .infinity)
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(store.recipes) { recipe in
                            Button {
                                presentedRecipe = recipe
                            } label: {
                                cell(for: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cream)
        .fullScreenCover(item: $presentedRecipe) { recipe in
            RecipeProfileView(recipe: recipe)
        }
    }
}

private extension SavedRecipesView {
    var columns: [GridItem] {
        [
            .init(.flexible(), spacing: 12),
            .init(.flexible(), spacing: 12)
        ]
    }

    var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "heart")
                .font(.system(size: 40))
                .foregroundStyle(Color.coffee.opacity(0.5))
            Text("No saved recipes yet")
                .font(.headline)
                .foregroundStyle(Color.coffee)
            Text("Swipe right on a recipe to save it here.")
                .font(.subheadline)
                .foregroundStyle(Color.coffee.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    func cell(for recipe: Recipe) -> some View {
//        VStack(alignment: .leading, spacing: 6) {
//            if let imageName = recipe.imageURLs.first {
//                Image(imageName)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 180)
//                    .clipped()
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//            } else {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color.coffee.opacity(0.08))
//                    .frame(height: 180)
//            }
//
//            Text(recipe.name)
//                .font(.subheadline)
//                .fontWeight(.semibold)
//                .lineLimit(1)
//                .foregroundStyle(Color.coffee)
// 
//        }
        
        ZStack(alignment: .bottomLeading) {
            if let imageURL = recipe.imageURLs.first.flatMap(URL.init(string:)) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.coffee.opacity(0.08)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.coffee.opacity(0.08))
                    .frame(height: 180)
            }

            Text(recipe.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
//                .foregroundStyle(Color.coffee)
                .foregroundStyle(Color.cream)
                .padding()
                .frame(maxWidth:.infinity, alignment:.bottomLeading)
                .background(
                    LinearGradient(colors: [.clear, Color.coffee], startPoint: .top, endPoint: .bottom),
                    in: RoundedRectangle(cornerRadius:10)
                )
 
        }
    }
}

struct SavedRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        let store = SavedRecipes()
        store.save(MockData.recipes[0])
        store.save(MockData.recipes[1])
        return SavedRecipesView()
            .environmentObject(store)
    }
}
