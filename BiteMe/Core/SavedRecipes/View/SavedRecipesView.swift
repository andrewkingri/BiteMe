//
//  SavedRecipesView.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject private var store: SavedRecipes
    @EnvironmentObject private var menus: Menus
    @State private var presentedRecipe: Recipe?
    @State private var menuSheetRecipe: Recipe?
    @State private var menusCollapsed = false

    private func setMenusCollapsed(_ collapsed: Bool) {
        guard collapsed != menusCollapsed else { return }
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            menusCollapsed = collapsed
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Saved")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.coffee)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                if !menus.menus.isEmpty {
                    menuStrip
                        .padding(.top)
                        .padding(.bottom)
                }

                if store.recipes.isEmpty {
                    Spacer()
                    emptyState
                        .frame(maxWidth: .infinity)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(store.recipes) { recipe in
                                    cell(for: recipe)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            presentedRecipe = recipe
                                        }
                                        .transition(.scale(scale: 0.8).combined(with: .opacity))
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.top, 12)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: store.recipes.map(\.id))
                            .overlay {
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(
                                            key: ScrollOffsetKey.self,
                                            value: proxy.frame(in: .named("savedScroll")).minY
                                        )
                                        .allowsHitTesting(false)
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "savedScroll")
                    .onPreferenceChange(ScrollOffsetKey.self) { offset in
                        // Hysteresis: collapse after scrolling down a bit,
                        // only unfold once we're essentially back at the top.
                        if menusCollapsed {
                            if offset > -4 { setMenusCollapsed(false) }
                        } else {
                            if offset < -24 { setMenusCollapsed(true) }
                        }
                    }
                    .overlay(alignment: .top) {
                        LinearGradient(
                            colors: [Color.cream, Color.cream.opacity(0)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 24)
                        .allowsHitTesting(false)
                    }
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
}

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private extension SavedRecipesView {
    var columns: [GridItem] {
        [
            .init(.flexible(), spacing: 12),
            .init(.flexible(), spacing: 12)
        ]
    }

    var menuStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(menus.menus) { menu in
                    NavigationLink {
                        MenuDetailView(menuID: menu.id)
                    } label: {
                        menuCard(menu)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    func menuCard(_ menu: RecipeMenu) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                if let urlString = menu.recipes.first?.imageURLs.first,
                   let url = URL(string: urlString) {
                    CachedAsyncImage(url: url) {
                        Color.coffee.opacity(0.08)
                    }
                    .scaledToFill()
                } else {
                    Color.coffee.opacity(0.08)
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(Color.mustard)
                }
            }
            .frame(width: menusCollapsed ? 0 : 140, height: menusCollapsed ? 0 : 100)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                Text(menu.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.coffee)
                    .lineLimit(1)
                Text("\(menu.recipes.count)")
                    .font(.caption)
                    .foregroundStyle(Color.coffee.opacity(0.6))
            }

//            Text(menu.name)
//                .font(.subheadline)
//                .fontWeight(.semibold)
//                .foregroundStyle(Color.coffee)
//                .lineLimit(1)
//            Text("\(menu.recipes.count) recipe\(menu.recipes.count == 1 ? "" : "s")")
//                .font(.caption)
//                .foregroundStyle(Color.coffee.opacity(0.6))
        }
        .frame(width: menusCollapsed ? nil : 140, alignment: .leading)
    }

    var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "heart")
                .font(.system(size: 40))
                .foregroundStyle(Color.coffee.opacity(0.5))
            Text("No saved recipes yet")
                .font(.headline)
                .foregroundStyle(Color.coffee)
            Text("Swipe right on a recipe to save it here.")
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
                .frame(maxWidth:.infinity, alignment:.bottomLeading)
                .background(
                    LinearGradient(colors: [.clear, Color.coffee], startPoint: .top, endPoint: .bottom),
                    in: RoundedRectangle(cornerRadius:10)
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
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.mustard)
                .padding(8)
        }
        .buttonStyle(.plain)
    }
}

struct SavedRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        let store = SavedRecipes()
        store.save(MockData.recipes[0])
        store.save(MockData.recipes[1])
        return SavedRecipesView()
            .environmentObject(store)
            .environmentObject(Menus())
    }
}
