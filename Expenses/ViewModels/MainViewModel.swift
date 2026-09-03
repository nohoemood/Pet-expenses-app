// MainViewModel.swift by mac 29.08.2026 

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    private let dataSource = MockData()
    @Published var expenses: [Expense] = []
    public let typesOfPrice = TypeOfPrice.allCases
    
    @Published var selectedTypeOfPrice = TypeOfPrice.all
    
    var filteredExpenses: [Expense] {
        if selectedTypeOfPrice == .all {
            return expenses
        } else {
            return expenses.filter { $0.typeOfPrice == selectedTypeOfPrice }
        }
    }
    
    var allPricesAmount: Double {
        var sum = 0.0
        for expense in filteredExpenses {
            sum += expense.price
        }
        return sum
    }
    
    init() {
        updateData()
    }
    
    public func updateData() {
        self.expenses = dataSource.expenses
    }
    
    public func addExpense(name: String, price: Double, typeOfExpense: TypeOfExpense) {
        dataSource.addExpense(name: name, price: price, typeOfExpense: typeOfExpense)
        updateData()
    }
    
    public func removeExpense(expense: Expense) {
        dataSource.deleteExpense(expense)
        updateData()
    }
}
