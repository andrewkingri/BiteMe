//
//  CardStackView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct CardStackView: View {
    @StateObject var viewModel = CardsViewModel(service: CardService())
    
    var body: some View {
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
                    } // for
                } // Z
                
                if !viewModel.cardModels.isEmpty {
                    SwipeActionButtonsView(viewModel: viewModel)
                }
            } // V
        }
    } // body
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
