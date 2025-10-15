//
//  SizeConstants.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation
import SwiftUI

struct SizeConstants {
    static var screenCutoff: CGFloat {
        UIScreen.main.bounds.width * 0.4
    }
    
    static var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    static var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
}
