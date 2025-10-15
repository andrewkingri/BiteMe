//
//  SwipeActionIndicatorView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct SwipeActionIndicatorView: View {
    
    @Binding var xOffset: CGFloat
        
    var body: some View {
        HStack {
            Text("YUM!")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.green)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.green, lineWidth: 2)
                        .frame(width: 100, height: 48)
                } // overlay
                .rotationEffect(.degrees(-45))
                .opacity(Double(xOffset / SizeConstants.screenCutoff))
            
            Spacer()
            
            Text("NOPE")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.red, lineWidth: 2)
                        .frame(width: 100, height: 48)
                } // overlay
                .rotationEffect(.degrees(45))
                .opacity(Double(xOffset / SizeConstants.screenCutoff * -1))
        } // HStack
        .padding(40)
    }
}

struct SwipeActionIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionIndicatorView(xOffset: .constant(20))
    }
}
