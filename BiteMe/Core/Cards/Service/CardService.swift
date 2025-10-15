//
//  CardService.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

struct CardService {
    func fetchCardModels() async throws -> [CardModel] {
        let recipes = MockData.recipes
        return recipes.map({ CardModel(recipe: $0) })
    }
}
