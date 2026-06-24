//
//  SearchView.swift
//  BiteMe
//
//  Created by Andrew King on 6/24/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject private var savedStore: SavedRecipes
    @State private var presentedRecipe: Recipe?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Search")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.coffee)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            searchField
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 8)

            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cream)
        .fullScreenCover(item: $presentedRecipe) { recipe in
            RecipeProfileView(recipe: recipe)
        }
    }
}

private extension SearchView {
    var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.coffee.opacity(0.6))

            TextField("Recipe name or ingredient", text: $viewModel.query)
                .foregroundStyle(Color.coffee)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .onSubmit { viewModel.search() }
                .onChange(of: viewModel.query) { _ in viewModel.search() }

            if !viewModel.query.isEmpty {
                Button {
                    viewModel.query = ""
                    viewModel.search()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.coffee.opacity(0.5))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.coffee.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
    }

    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView()
                .tint(Color.coffee)
                .frame(maxWidth: .infinity)
            Spacer()
        } else if viewModel.results.isEmpty {
            Spacer()
            emptyState
                .frame(maxWidth: .infinity)
            Spacer()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.results) { recipe in
                        cell(for: recipe)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                presentedRecipe = recipe
                            }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
            }
        }
    }

    var columns: [GridItem] {
        [
            .init(.flexible(), spacing: 12),
            .init(.flexible(), spacing: 12)
        ]
    }

    var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(Color.coffee.opacity(0.5))
            Text(viewModel.didSearch ? "No recipes found" : "Find your next meal")
                .font(.headline)
                .foregroundStyle(Color.coffee)
            Text(viewModel.didSearch
                 ? "Try a different name or ingredient."
                 : "Search by recipe name or ingredient.")
                .font(.subheadline)
                .foregroundStyle(Color.coffee.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    func cell(for recipe: Recipe) -> some View {
        ZStack(alignment: .bottomLeading) {
            CachedAsyncImage(url: recipe.imageURLs.first.flatMap(URL.init(string:))) {
                Color.coffee.opacity(0.08)
            }
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(recipe.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
                .foregroundStyle(Color.cream)
                .padding()
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .background(
                    LinearGradient(colors: [.clear, Color.coffee], startPoint: .top, endPoint: .bottom),
                    in: RoundedRectangle(cornerRadius: 10)
                )
        }
        .overlay(alignment: .topTrailing) {
            saveButton(for: recipe)
                .padding(8)
        }
    }

    @ViewBuilder
    func saveButton(for recipe: Recipe) -> some View {
        let isSaved = savedStore.recipes.contains(where: { $0.id == recipe.id })
        Button {
            if isSaved {
                savedStore.remove(recipe)
            } else {
                savedStore.save(recipe)
            }
        } label: {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(isSaved ? Color.red : Color.cream)
                .padding(8)
        }
        .buttonStyle(.plain)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SavedRecipes())
    }
}
