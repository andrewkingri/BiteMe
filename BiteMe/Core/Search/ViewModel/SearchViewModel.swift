//
//  SearchViewModel.swift
//  BiteMe
//
//  Created by Andrew King on 6/24/26.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var results: [Recipe] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var didSearch: Bool = false

    private let service: MealDBService
    private var searchTask: Task<Void, Never>?

    init(service: MealDBService = MealDBService()) {
        self.service = service
    }

    func search() {
        searchTask?.cancel()

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            results = []
            isLoading = false
            didSearch = false
            return
        }

        searchTask = Task { [weak self] in
            guard let self else { return }

            try? await Task.sleep(nanoseconds: 300_000_000)
            if Task.isCancelled { return }

            self.isLoading = true
            do {
                let recipes = try await self.service.searchRecipes(matching: trimmed)
                if Task.isCancelled { return }
                self.results = recipes
            } catch {
                if Task.isCancelled { return }
                print("DEBUG: search failed with error: \(error)")
                self.results = []
            }
            self.isLoading = false
            self.didSearch = true
        }
    }
}
