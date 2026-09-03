import Foundation
import UIKit
import SwiftUI

class CategoryCVCell: UICollectionViewCell {
    
    private var expenseViewModel: ExpenseViewModel?

    private let catergoryView: UIView = {
        let catergoryView = UIView()
        catergoryView.backgroundColor = UIColor(named: "Background_1")
        catergoryView.layer.borderColor = UIColor(named: "Stroke")?.cgColor
        catergoryView.layer.borderWidth = 1
        catergoryView.layer.cornerRadius = 20
        catergoryView.translatesAutoresizingMaskIntoConstraints = false
        return catergoryView
    }()
    
    private let catergoryLabel: UILabel = {
        let catergoryLabel = UILabel()
        catergoryLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        catergoryLabel.textColor = .label
        catergoryLabel.textAlignment = .center
        catergoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return catergoryLabel
    }()
    
    // MARK: - Init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(catergoryView)
        contentView.addSubview(catergoryLabel)
        
        NSLayoutConstraint.activate([
            // View
            catergoryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            catergoryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            catergoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            catergoryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Label
            catergoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            catergoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            catergoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(typeOfExpense: TypeOfExpense, expenseViewModel: ExpenseViewModel) {
        catergoryLabel.text = typeOfExpense.rawValue
        self.expenseViewModel = expenseViewModel

        updateAppearance()
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
        
    func updateAppearance() {
        guard let unwrappedExpenseViewModel = self.expenseViewModel else { return }
        
        let activeColor = UIColor(unwrappedExpenseViewModel.selectedPriceType.color)
        let inactiveColor = UIColor(named: "Background_1")
        let inactiveStroke = UIColor(named: "Stroke")?.cgColor
        
        UIView.animate(withDuration: 0.5) {
            if self.isSelected {
                self.catergoryView.backgroundColor = activeColor
                self.catergoryView.layer.borderColor = activeColor.cgColor
                self.catergoryLabel.textColor = .black
            } else {
                self.catergoryView.backgroundColor = inactiveColor
                self.catergoryView.layer.borderColor = inactiveStroke
                self.catergoryLabel.textColor = .label
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
}
