// CategoryCVDelegate.swift by mac 02.09.2026

import Foundation
import UIKit

class CategoryCVDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var expenseViewModel: ExpenseViewModel?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        guard let unwrappedViewModel = expenseViewModel else { return }
        let selectedType = unwrappedViewModel.typesOfExpense[indexPath.item]
        
        unwrappedViewModel.selectedExpenseType = selectedType
        
        print("Tap on \(indexPath.item)")
    }
}
