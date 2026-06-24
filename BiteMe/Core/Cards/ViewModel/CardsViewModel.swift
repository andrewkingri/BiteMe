//
//  CardsViewModel.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

@MainActor
class CardsViewModel: ObservableObject {
    @Published var cardModels = [CardModel]()
    @Published var buttonSwipeAction: SwipeAction?

    private let service: CardService
    private var catalog: [Recipe] = []
    private var deck: [Recipe] = []
    private let visibleWindow = 10

    init(service: CardService) {
        self.service = service
        Task { await loadCatalog() }
    }

    func loadCatalog() async {
        do {
            catalog = try await service.fetchRecipeCatalog()
            deck = catalog.shuffled()
            cardModels = []
            refillVisibleCards(initial: true)
        } catch {
            print("DEBUG: failed to fetch cards with error: \(error)")
        }
    }

    func removeCard(_ card: CardModel) {
        Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            guard let index = cardModels.firstIndex(where: { $0.id == card.id }) else { return }
            cardModels.remove(at: index)
            refillVisibleCards()
        }
    }

    private func refillVisibleCards(initial: Bool = false) {
        guard !catalog.isEmpty else { return }
        while cardModels.count < visibleWindow {
            if deck.isEmpty {
                deck = catalog.shuffled()
            }
            let card = CardModel(recipe: deck.removeFirst())
            if initial {
                cardModels.append(card)
            } else {
                cardModels.insert(card, at: 0)
            }
        }
    }
}
