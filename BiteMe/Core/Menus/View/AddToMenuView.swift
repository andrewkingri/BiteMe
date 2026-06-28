//
//  AddToMenuView.swift
//  BiteMe
//
//  Created by Andrew King on 6/27/26.
//

import SwiftUI

struct AddToMenuView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var menus: Menus

    let recipe: Recipe

    @State private var isCreatingNewMenu = false
    @State private var newMenuName = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if menus.menus.isEmpty {
                    emptyState
                } else {
                    menuList
                }

                Divider()

                if isCreatingNewMenu {
                    createMenuField
                } else {
                    createMenuButton
                }
            }
            .background(Color.cream)
            .navigationTitle("Add to Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color.coffee)
                }
            }
        }
    }
}

private extension AddToMenuView {
    var menuList: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(menus.menus) { menu in
                    Button {
                        menus.addRecipe(recipe, to: menu.id)
                        dismiss()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "book.closed.fill")
                                .foregroundStyle(Color.mustard)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(menu.name)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.coffee)
                                Text("\(menu.recipes.count) recipe\(menu.recipes.count == 1 ? "" : "s")")
                                    .font(.caption)
                                    .foregroundStyle(Color.coffee.opacity(0.6))
                            }

                            Spacer()

                            if menus.contains(recipe, in: menu.id) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.herbGreen)
                            }
                        }
                        .padding()
                        .background(Color.coffee.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    .disabled(menus.contains(recipe, in: menu.id))
                }
            }
            .padding()
        }
    }

    var emptyState: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "book")
                .font(.system(size: 40))
                .foregroundStyle(Color.coffee.opacity(0.5))
            Text("No menus yet")
                .font(.headline)
                .foregroundStyle(Color.coffee)
            Text("Create a menu below to get started.")
                .font(.subheadline)
                .foregroundStyle(Color.coffee.opacity(0.6))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    var createMenuButton: some View {
        Button {
            withAnimation {
                isCreatingNewMenu = true
            }
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color.mustard)
                Text("Create New Menu")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(Color.mustard)
            .frame(maxWidth: .infinity)
            .padding()
        }
    }

    var createMenuField: some View {
        HStack(spacing: 8) {
            TextField("Menu name", text: $newMenuName)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .onSubmit(createMenuAndAdd)

            Button {
                createMenuAndAdd()
            } label: {
                Text("Add")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.mustard)
            }
            .disabled(trimmedName.isEmpty)

            Button {
                withAnimation {
                    isCreatingNewMenu = false
                    newMenuName = ""
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(Color.coffee.opacity(0.5))
            }
        }
        .padding()
    }

    var trimmedName: String {
        newMenuName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func createMenuAndAdd() {
        let name = trimmedName
        guard !name.isEmpty else { return }
        let menu = menus.createMenu(name: name)
        menus.addRecipe(recipe, to: menu.id)
        dismiss()
    }
}

struct AddToMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AddToMenuView(recipe: MockData.recipes[0])
            .environmentObject(Menus())
    }
}
