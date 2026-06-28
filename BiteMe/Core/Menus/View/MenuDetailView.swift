//
//  MenuDetailView.swift
//  BiteMe
//
//  Created by Andrew King on 6/27/26.
//

import SwiftUI

struct MenuDetailView: View {
    @EnvironmentObject private var menus: Menus
    @Environment(\.dismiss) private var dismiss

    let menuID: RecipeMenu.ID

    @State private var presentedRecipe: Recipe?
    @State private var menuSheetRecipe: Recipe?

    private var menu: RecipeMenu? {
        menus.menus.first(where: { $0.id == menuID })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

            if let menu, !menu.recipes.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(menu.recipes) { recipe in
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
            } else {
                Spacer()
                emptyState
                    .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cream)
        .navigationBarHidden(true)
        .fullScreenCover(item: $presentedRecipe) { recipe in
            RecipeProfileView(recipe: recipe)
        }
        .sheet(item: $menuSheetRecipe) { recipe in
            AddToMenuView(recipe: recipe)
        }
    }
}

private extension MenuDetailView {
    var columns: [GridItem] {
        [
            .init(.flexible(), spacing: 12),
            .init(.flexible(), spacing: 12)
        ]
    }

    var header: some View {
        HStack(alignment: .center, spacing: 12) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.coffee)
            }

            Text(menu?.name ?? "Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.coffee)
                .lineLimit(1)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "book")
                .font(.system(size: 40))
                .foregroundStyle(Color.coffee.opacity(0.5))
            Text("No recipes in this menu yet")
                .font(.headline)
                .foregroundStyle(Color.coffee)
            Text("Add recipes to this menu from your saved list.")
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
            addToMenuButton(for: recipe)
                .padding(8)
        }
    }

    func addToMenuButton(for recipe: Recipe) -> some View {
        Button {
            menuSheetRecipe = recipe
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color.mustard)
                .padding(8)
        }
        .buttonStyle(.plain)
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let menus = Menus()
        let created = menus.createMenu(name: "Weeknight Dinners")
        menus.addRecipe(MockData.recipes[0], to: created.id)
        menus.addRecipe(MockData.recipes[1], to: created.id)
        return NavigationView {
            MenuDetailView(menuID: created.id)
        }
        .environmentObject(menus)
    }
}
