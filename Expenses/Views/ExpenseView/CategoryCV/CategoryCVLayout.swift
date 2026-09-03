// CategoryCVLayout.swift by mac 02.09.2026

import Foundation
import UIKit

enum CategoryCVLayout {
    
    static func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(82.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
                
        let section = NSCollectionLayoutSection(group: group)
                
        return UICollectionViewCompositionalLayout(section: section)
    }
}
