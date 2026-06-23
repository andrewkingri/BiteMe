//
//  SavedRecipes.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import Foundation

@MainActor
class SavedRecipes: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []

    func save(_ recipe: Recipe) {
        guard !recipes.contains(where: { $0.id == recipe.id }) else { return }
        recipes.append(recipe)
    }

    func remove(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
    }
}


