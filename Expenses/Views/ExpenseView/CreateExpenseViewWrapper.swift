// ExpenseViewWrapper.swift by mac 30.08.2026

import SwiftUI
import UIKit

struct ExpenseViewWrapper: UIViewRepresentable {

    var onSave: (String, Double, TypeOfExpense) -> Void

    func makeUIView(context: Context) -> UIView {
        let view = CreateExpenseView()

        view.saveButton.addTarget(context.coordinator, action: #selector(Coordinator.saveTapped(_:)), for: .touchUpInside)

        context.coordinator.uiView = view
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: ExpenseViewWrapper
        weak var uiView: CreateExpenseView?

        init(_ parent: ExpenseViewWrapper) {
            self.parent = parent
        }

        @objc func saveTapped(_ sender: UIButton) {
            guard let uiView = uiView else { return }

            let title = uiView.expenseViewModel.titleText
            let amount = uiView.expenseViewModel.amountSum
            let category = uiView.expenseViewModel.selectedExpenseType

            if title == "" || amount == 0.0 {
                print("You should fill in all the fields")
                return
            }
            
            parent.onSave(title, amount, category)
        }
    }
}
