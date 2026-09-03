// CategoryCVDataSource.swift by mac 02.09.2026

import Foundation
import UIKit

class CategoryCVDataSource: NSObject, UICollectionViewDataSource {

    var expenseViewModel: ExpenseViewModel?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let unwrappedExpenseViewModel = expenseViewModel else { return 0 }
        return unwrappedExpenseViewModel.typesOfExpense.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCVCell
            
        guard let unwrappedExpenseViewModel = expenseViewModel else { return cell }
        let currentType = unwrappedExpenseViewModel.typesOfExpense[indexPath.item]
        let isThisSelected = currentType == unwrappedExpenseViewModel.selectedExpenseType
            
        cell.configure(typeOfExpense: currentType, expenseViewModel: unwrappedExpenseViewModel)
        cell.isSelected = isThisSelected
            
        return cell
    }
}
