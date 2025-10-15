//
//  CardImageIndicatorView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct CardImageIndicatorView: View {
    let currentImageIndex: Int
    let imageCount: Int
    
    var body: some View {
        HStack {
            ForEach(0 ..< imageCount, id: \.self) { index in
                Capsule()
                    .foregroundStyle(currentImageIndex == index ? .white : .gray)
                    .frame(width: imageIndicatorWidth, height: 4)
                    .padding(.top, 8)
            }
        }
    }
}

private extension CardImageIndicatorView {
    var imageIndicatorWidth: CGFloat {
        return SizeConstants.cardWidth / CGFloat(imageCount) - 28
    }
}

struct CardImageIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        CardImageIndicatorView(currentImageIndex: 1, imageCount: 4)
            .preferredColorScheme(.dark)
    }
}
