//
//  CardView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardsViewModel
    
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var currentImageIndex: Int = 0
    @State private var showRecipeModal: Bool = false
    
    let model: CardModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                Image(recipe.imageURLs[currentImageIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                    .overlay {
                        ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: imageCount)
                    }
                
                CardImageIndicatorView(currentImageIndex: currentImageIndex, imageCount: imageCount)
                
                SwipeActionIndicatorView(xOffset: $xOffset)
            }
                
            
            RecipeInfoView(showRecipeModal: $showRecipeModal, recipe: recipe)
            
        } // ZStack
        .fullScreenCover(isPresented: $showRecipeModal, onDismiss: { }, content: {
            RecipeProfileView(recipe: recipe)
        })
        .onReceive(viewModel.$buttonSwipeAction, perform: { action in
            onReceiveSwipeAction(action)
        })
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.spring(), value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
//                .onChanged({ value in
//                    onDragChanged(value)
//                })
//                .onEnded({ value in
//                    onDragEnded(value)
//                })
        ) // gesture
    }
}

private extension CardView {
    var recipe: Recipe {
        return model.recipe
    }
    
    var imageCount: Int {
        return recipe.imageURLs.count
    }
}

private extension CardView {
    func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        xOffset = 500
        degrees = 12
        
        viewModel.removeCard(model)
        
        
    }
    
    func swipeLeft() {
        xOffset = -500
        degrees = -12
        
        viewModel.removeCard(model)
    }
    
    func onReceiveSwipeAction(_ action: SwipeAction?) {
        if action != nil {
            
        } else {
            return
        }
//        guard let action else { return }
        
        let topCard = viewModel.cardModels.last
        
        if topCard == model {
            switch action {
            case .reject:
                swipeLeft()
            case .like:
                swipeRight()
            case .none:
                return
            case .some(_):
                return
            }
        }
    }
}

private extension CardView {
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        
        if abs(width) <= abs(SizeConstants.screenCutoff) {
            returnToCenter()
            return
        }
        
        if width >= SizeConstants.screenCutoff {
            swipeRight()
        } else {
            swipeLeft()
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            viewModel: CardsViewModel(
                service: CardService()
            ),
            model: CardModel(
                recipe: MockData.recipes[1]
            )
        ) // CardsView
    }
} // CardView_Previews
