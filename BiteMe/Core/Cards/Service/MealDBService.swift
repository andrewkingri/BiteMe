//
//  MealDBService.swift
//  BiteMe
//
//  Created by Andrew King on 6/24/26.
//

import Foundation

struct MealDBService {
    private static let baseURL = "https://www.themealdb.com/api/json/v1/1"

    func fetchRandomRecipes(count: Int = 10) async throws -> [Recipe] {
        try await withThrowingTaskGroup(of: Recipe?.self) { group in
            for _ in 0..<count {
                group.addTask { try await fetchRandomRecipe() }
            }

            var recipes: [Recipe] = []
            var seenIDs: Set<String> = []
            for try await recipe in group {
                guard let recipe, !seenIDs.contains(recipe.id) else { continue }
                seenIDs.insert(recipe.id)
                recipes.append(recipe)
            }
            return recipes
        }
    }

    private func fetchRandomRecipe() async throws -> Recipe? {
        guard let url = URL(string: "\(Self.baseURL)/random.php") else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        return response.meals.first.map(Recipe.init(meal:))
    }
}

private struct MealDBResponse: Decodable {
    let meals: [MealDBMeal]
}

private struct MealDBMeal: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strMealThumb: String
    let ingredients: [String]

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

        var collected: [String] = []
        for index in 1...20 {
            guard let key = DynamicKey(stringValue: "strIngredient\(index)") else { continue }
            let value = try container.decodeIfPresent(String.self, forKey: key)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if let value, !value.isEmpty {
                collected.append(value)
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
        self.ingredients = meal.ingredients.prefix(5).joined(separator: ", ")
        self.imageURLs = [meal.strMealThumb]
    }
}
