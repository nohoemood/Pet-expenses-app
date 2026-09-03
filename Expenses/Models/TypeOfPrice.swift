// TypeOfExpense.swift by mac 28.08.2026

import Foundation
import SwiftUI

enum TypeOfPrice: String, CaseIterable {
    case all = "All"
    case high = "High"
    case middle = "Middle"
    case low = "Low"

    var color: Color {
        switch self {
        case .all:
            return Color("PriceGray")
        case .high:
            return Color("PriceRed")
        case .middle:
            return Color("PriceYellow")
        case .low:
            return Color("PriceGreen")
        }
    }
    
    var activeDashes: Int {
        switch self {
        case .high:
            return 3
        case .middle:
            return 2
        case .low:
            return 1
        default:
            return 0
        }
    }
}
