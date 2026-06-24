//
//  MealDBService.swift
//  BiteMe
//
//  Created by Andrew King on 6/24/26.
//

import Foundation

struct MealDBService {
    private static let baseURL = "https://www.themealdb.com/api/json/v1/1"
    private static let catalogLetters = Array("abcdefghijklmnopqrstuvwxyz")

    func fetchAllRecipes() async throws -> [Recipe] {
        try await withThrowingTaskGroup(of: [Recipe].self) { group in
            for letter in Self.catalogLetters {
                group.addTask { try await fetchRecipes(startingWith: letter) }
            }

            var recipes: [Recipe] = []
            var seenIDs: Set<String> = []
            for try await batch in group {
                for recipe in batch where !seenIDs.contains(recipe.id) {
                    seenIDs.insert(recipe.id)
                    recipes.append(recipe)
                }
            }
            return recipes
        }
    }

    private func fetchRecipes(startingWith letter: Character) async throws -> [Recipe] {
        guard let url = URL(string: "\(Self.baseURL)/search.php?f=\(letter)") else { return [] }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        return (response.meals ?? []).map(Recipe.init(meal:))
    }
}

private struct MealDBResponse: Decodable {
    let meals: [MealDBMeal]?
}

private struct MealDBMeal: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strMealThumb: String
    let strInstructions: String?
    let ingredients: [Ingredient]

    private struct DynamicKey: CodingKey {
        var stringValue: String
        var intValue: Int? { nil }
        init?(stringValue: String) { self.stringValue = stringValue }
        init?(intValue: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)

        idMeal = try container.decode(String.self, forKey: DynamicKey(stringValue: "idMeal")!)
        strMeal = try container.decode(String.self, forKey: DynamicKey(stringValue: "strMeal")!)
        strCategory = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strCategory")!)
        strArea = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strArea")!)
        strMealThumb = try container.decode(String.self, forKey: DynamicKey(stringValue: "strMealThumb")!)
        strInstructions = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strInstructions")!)?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        var collected: [Ingredient] = []
        for index in 1...20 {
            guard
                let nameKey = DynamicKey(stringValue: "strIngredient\(index)"),
                let measureKey = DynamicKey(stringValue: "strMeasure\(index)")
            else { continue }
            let name = try container.decodeIfPresent(String.self, forKey: nameKey)?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let measure = try container.decodeIfPresent(String.self, forKey: measureKey)?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            if !name.isEmpty {
                collected.append(Ingredient(name: name, measure: measure))
            }
        }
        ingredients = collected
    }
}

private extension Recipe {
    init(meal: MealDBMeal) {
        self.id = meal.idMeal
        self.name = meal.strMeal
        self.dietTags = meal.strCategory ?? ""
        self.ingredients = meal.ingredients
        self.instructions = meal.strInstructions ?? ""
        self.imageURLs = [meal.strMealThumb]
    }
}
