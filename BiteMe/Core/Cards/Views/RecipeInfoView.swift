//
//  RecipeInfoView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct RecipeInfoView: View {
    @Binding var showRecipeModal: Bool
    
    let recipe: Recipe
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text(recipe.dietTags)
                    .font(.title)
                    .fontWeight(.ultraLight)
                
                Spacer()
                
                Button {
                    showRecipeModal.toggle()
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .imageScale(.large)
                        .font(Font.body.weight(.bold))
                } // button label
            } // HStack
            
            Text(recipe.ingredients)
                .font(.subheadline)
                .lineLimit(2)
        } // VStack
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
        
        
    } // body
} // RIV

struct RecipeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfoView(showRecipeModal: .constant(false), recipe: MockData.recipes[1])
    }
}
