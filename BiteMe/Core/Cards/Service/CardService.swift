//
//  CardService.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

struct CardService {
    private let mealDBService = MealDBService()

    func fetchRecipeCatalog() async throws -> [Recipe] {
        try await mealDBService.fetchAllRecipes()
    }
}
