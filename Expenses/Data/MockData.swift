// Storage.swift by mac 28.08.2026 

import Foundation

final class MockData {
    
    var expenses = [
        Expense(name: "Office rent", price: 1530.0, typeOfExpense: .work),
        Expense(name: "Surgery", price: 850.0, typeOfExpense: .health),
        Expense(name: "Food", price: 321.0, typeOfExpense: .health),
        Expense(name: "Gym", price: 85.0, typeOfExpense: .sport),
        Expense(name: "Gasoline", price: 631.0, typeOfExpense: .work),
        Expense(name: "Drugs", price: 1120.0, typeOfExpense: .mind)
    ]
    
    func addExpense(name: String, price: Double, typeOfExpense: TypeOfExpense) {
        expenses.append(Expense(name: name, price: price, typeOfExpense: typeOfExpense))
    }
    
    func deleteExpense(_ expense: Expense) {
        expenses.removeAll(where: { $0.id == expense.id })
    }
}
