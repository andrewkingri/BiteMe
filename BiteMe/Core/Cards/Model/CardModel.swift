//
//  CardModel.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

struct CardModel {
    let recipe: Recipe
}

extension CardModel: Identifiable, Hashable {
    var id: String { return recipe.id }
}
