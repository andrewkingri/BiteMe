//
//  CardService.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

struct CardService {
    private let mealDBService = MealDBService()

    func fetchCardModels() async throws -> [CardModel] {
        let recipes = try await mealDBService.fetchRandomRecipes()
        return recipes.map({ CardModel(recipe: $0) })
    }
}
