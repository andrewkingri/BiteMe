//
//  CardStackView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct CardStackView: View {
    @State private var showMatchView = true
    @StateObject var viewModel = CardsViewModel(service: CardService())
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                // Logo
                Image("Biteme")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 35)
                
                // Card Stack
                VStack(spacing: 16) {
                    
                    ZStack {
                        ForEach(viewModel.cardModels) { card in
                            CardView(viewModel: viewModel, model: card)
                        }
                    }
                    
                    if !viewModel.cardModels.isEmpty {
                        SwipeActionButtonsView(viewModel: viewModel)
                    }
                }
            }
            .blur(radius: showMatchView ? 20 : 0)
            
            if showMatchView {
                RecipeMatchView(show: $showMatchView)
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
