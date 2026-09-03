// Expense.swift by mac 28.08.2026 

import Foundation

final class Expense: Identifiable {
    let id = UUID()
    
    let name: String
    let price: Double
    let typeOfExpense: TypeOfExpense
    
    var typeOfPrice: TypeOfPrice {
        switch price {
        case 0..<500:
            return .low
        case 500..<1000:
            return .middle
        case 1000...:
            return .high
        default:
            return .all
        }
    }
    
    // MARK: - init
    init(name: String, price: Double, typeOfExpense: TypeOfExpense) {
        self.name = name
        self.price = price
        self.typeOfExpense = typeOfExpense
    }
    
}
