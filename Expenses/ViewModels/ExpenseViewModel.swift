// ExpenseViewModel.swift by mac 30.08.2026 

import Foundation

final class ExpenseViewModel {
    
    public var placeHolderAmountText: String = "Price ..."
    public var placeHolderTitleText: String = "Name ..."
    
    public var amountSum: Double = 0.0
    public var titleText: String = ""
    
    public var selectedExpenseType: TypeOfExpense = .work
    public var selectedPriceType: TypeOfPrice = .low
    
    public let typesOfExpense: [TypeOfExpense]
    
    public var isCategorySelected: Bool = false
    
    init() {
        self.typesOfExpense = TypeOfExpense.allCases
    }
    
}
