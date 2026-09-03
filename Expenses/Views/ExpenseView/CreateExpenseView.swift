// ExpenseView.swift by mac 30.08.2026

import Foundation
import SwiftUI
import UIKit

class CreateExpenseView: UIView {
    
    // MARK: - Data
    let expenseViewModel = ExpenseViewModel()
    
    /// Text fields
    private let priceTextFieldDelegate = PriceTextFieldDelegate()
    private let nameTextFieldDelegate = NameTextFieldDelegate()
    
    /// Collection view
    private let categoryCVDelegate = CategoryCVDelegate()
    private let categoryCVDataSource = CategoryCVDataSource()
    
    // MARK: - UI
    /// Price
    private let priceCardTitleLabel = CreateExpenseViewFactory.getLabel(text: "Price", weight: .bold, size: 18, onCenter: false)
    private let priceCardView = CreateExpenseViewFactory.getCardView(backgroundColor: UIColor(named: "Background_1")!, cornerRadius: 16)
    private let priceCardSecondTitleLabel = CreateExpenseViewFactory.getLabel(text: "Primary expense value", weight: .regular, size: 18, onCenter: false)
    private let priceCardAmountTextField = CreateExpenseViewFactory.getTextField(size: 54, weight: .bold, numberKeyboard: true)
    private let priceCardTypeOfPriceView = CreateExpenseViewFactory.getCardView(backgroundColor: UIColor(named: "Background_2")!, cornerRadius: 12)
    private let priceCardCircleView = CreateExpenseViewFactory.getCardView(backgroundColor: UIColor(named: "PriceGreen")!, cornerRadius: 6)
    private let priceCardTypeOfPriceLabel = CreateExpenseViewFactory.getLabel(text: "Low", weight: .semibold, size: 12, onCenter: true)
    
    /// Name
    private let nameCardTitleLabel = CreateExpenseViewFactory.getLabel(text: "Title", weight: .bold, size: 18, onCenter: false)
    private let nameCardView = CreateExpenseViewFactory.getCardView(backgroundColor: UIColor(named: "Background_1")!, cornerRadius: 16)
    private let nameCardTextField = CreateExpenseViewFactory.getTextField(size: 22, weight: .bold, numberKeyboard: false)
    private let nameCardSFImage = CreateExpenseViewFactory.getImageView()
    
    private let priceCardAnimatedCircle: AnimatedCircleView = {
        let priceCardAnimatedCircle = AnimatedCircleView()
        priceCardAnimatedCircle.translatesAutoresizingMaskIntoConstraints = false
        return priceCardAnimatedCircle
    }()

    private var animationWorkItem: DispatchWorkItem?
    
    /// Category
    private let categoryTitleLabel = CreateExpenseViewFactory.getLabel(text: "Price", weight: .bold, size: 18, onCenter: false)
    
    private let categoryCollectionView: UICollectionView = {
        let layout = CategoryCVLayout.createLayout()
        let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        categoryCollectionView.register(CategoryCVCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.isScrollEnabled = false
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return categoryCollectionView
    }()
    
    /// Save button
    let saveButton = CreateExpenseViewFactory.getButton(title: "Save expense")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Background_2")
        
        setupTextFieldActions()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcs
    private func checkPriceType(text: String) {
        guard let unwrappedText = Int(text) else { return }
        
        let newTypeOfPrice: TypeOfPrice = switch unwrappedText {
        case 0..<500: .low
        case 500..<1000: .middle
        case 1000...: .high
        default: .all
        }
        
        guard expenseViewModel.selectedPriceType != newTypeOfPrice else {
            let amount = Double(text) ?? 0.0
            animationWorkItem?.cancel()
            let workItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.priceCardAnimatedCircle.animateProgress(to: amount, color: UIColor(self.expenseViewModel.selectedPriceType.color))
            }
            animationWorkItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: workItem)
            return
        }
        
        expenseViewModel.selectedPriceType = newTypeOfPrice
        let amount = Double(text) ?? 0.0
        let targetColor = UIColor(expenseViewModel.selectedPriceType.color)
        
        animationWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.4) {
                self.saveButton.backgroundColor = targetColor
                self.priceCardCircleView.backgroundColor = targetColor
                
                for cell in self.categoryCollectionView.visibleCells {
                    if let categoryCell = cell as? CategoryCVCell {
                        categoryCell.updateAppearance()
                    }
                }
            }
            
            UIView.transition(with: self.priceCardTypeOfPriceLabel, duration: 0.35, options: [.transitionCrossDissolve, .beginFromCurrentState, .curveEaseOut]) {
                self.priceCardTypeOfPriceLabel.text = text
            }
            
            let shadowAnimation = CABasicAnimation(keyPath: "shadowColor")
            shadowAnimation.fromValue = self.saveButton.layer.shadowColor
            shadowAnimation.toValue = targetColor.cgColor
            shadowAnimation.duration = 0.4
            self.saveButton.layer.add(shadowAnimation, forKey: "shadowColorAnimation")
            self.saveButton.layer.shadowColor = targetColor.cgColor
            
            self.priceCardAnimatedCircle.animateProgress(to: amount, color: targetColor)
        }
        animationWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45, execute: workItem)

        print("func've changed color to \(expenseViewModel.selectedPriceType.color)")
    }
    
    @objc private func handleTapOutside() {
        endEditing(true)
    }
    
    private func setupTextFieldActions() {
        // MARK: Price text field -
        priceCardAmountTextField.delegate = priceTextFieldDelegate
        priceTextFieldDelegate.onTextChanged = { [weak self] updatedText in
            self?.checkPriceType(text: updatedText)
        }
        
        let priceTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        priceTapGesture.cancelsTouchesInView = false
        addGestureRecognizer(priceTapGesture)
        
        priceCardAmountTextField.addAction(UIAction { [weak self] action in
            guard let textField = action.sender as? UITextField else { return }
            let currentText = textField.text ?? ""
            
            if let currentPrice = Double(currentText) {
                self?.expenseViewModel.amountSum = currentPrice
            } else {
                self?.expenseViewModel.amountSum = 0.0
            }
            
            print("Current price: \(currentText)")
        }, for: .editingChanged)
        
        priceCardAmountTextField.placeholder = expenseViewModel.placeHolderAmountText
        
        // MARK: Name text field -
        nameCardTextField.delegate = nameTextFieldDelegate
        nameTextFieldDelegate.onTextChanged = { [weak self] updatedText in
            self?.checkPriceType(text: updatedText)
        }
        let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        nameTapGesture.cancelsTouchesInView = false
        addGestureRecognizer(nameTapGesture)
        
        nameCardTextField.addAction(UIAction { [weak self] action in
            guard let textField = action.sender as? UITextField else { return }
            let currentText = textField.text ?? ""
                
            self?.expenseViewModel.titleText = currentText
            print("Current title: \(currentText)")
        }, for: .editingChanged)
        
        nameCardTextField.placeholder = expenseViewModel.placeHolderTitleText
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        // Name card image
        nameCardSFImage.image = UIImage(systemName: "text.pad.header")
        nameCardSFImage.tintColor = .label
        
        // Category collection view
        categoryCVDelegate.expenseViewModel = expenseViewModel
        categoryCVDataSource.expenseViewModel = expenseViewModel
        
        categoryCollectionView.delegate = categoryCVDelegate
        categoryCollectionView.dataSource = categoryCVDataSource
        
        // Save button
        saveButton.backgroundColor = UIColor(expenseViewModel.selectedPriceType.color)
        
        saveButton.layer.shadowColor = UIColor(expenseViewModel.selectedPriceType.color).cgColor
        saveButton.layer.shadowOpacity = 0.20
        saveButton.layer.shadowOffset = .zero
        saveButton.layer.shadowRadius = 15
        
        // Layout
        addSubview(priceCardTitleLabel)
        addSubview(priceCardView)
        priceCardView.addSubview(priceCardSecondTitleLabel)
        priceCardView.addSubview(priceCardAmountTextField)
        priceCardView.addSubview(priceCardTypeOfPriceView)
        priceCardTypeOfPriceView.addSubview(priceCardCircleView)
        priceCardTypeOfPriceView.addSubview(priceCardTypeOfPriceLabel)
        priceCardView.addSubview(priceCardAnimatedCircle)
        
        addSubview(nameCardTitleLabel)
        addSubview(nameCardView)
        nameCardView.addSubview(nameCardTextField)
        nameCardView.addSubview(nameCardSFImage)
        
        addSubview(categoryTitleLabel)
        addSubview(categoryCollectionView)
        
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            // MARK: Price card -
            // Price card title lable
            priceCardTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            priceCardTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Price card view
            priceCardView.topAnchor.constraint(equalTo: priceCardTitleLabel.bottomAnchor, constant: 10),
            priceCardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            priceCardView.widthAnchor.constraint(equalToConstant: 370),
            priceCardView.heightAnchor.constraint(equalToConstant: 152),
            
            // Price card second title label
            priceCardSecondTitleLabel.topAnchor.constraint(equalTo: priceCardView.topAnchor, constant: 16),
            priceCardSecondTitleLabel.leadingAnchor.constraint(equalTo: priceCardView.leadingAnchor, constant: 16),
            
            // Price card amount text field
            priceCardAmountTextField.topAnchor.constraint(equalTo: priceCardSecondTitleLabel.bottomAnchor, constant: 30),
            priceCardAmountTextField.leadingAnchor.constraint(equalTo: priceCardView.leadingAnchor, constant: 16),
            
            priceCardAmountTextField.widthAnchor.constraint(equalToConstant: 184),
            priceCardAmountTextField.heightAnchor.constraint(equalToConstant: 60),
            
            // Type card type of price view
            priceCardTypeOfPriceView.centerYAnchor.constraint(equalTo: priceCardSecondTitleLabel.centerYAnchor),
            priceCardTypeOfPriceView.trailingAnchor.constraint(equalTo: priceCardView.trailingAnchor, constant: -26),
            
            priceCardTypeOfPriceView.widthAnchor.constraint(equalToConstant: 81),
            priceCardTypeOfPriceView.heightAnchor.constraint(equalToConstant: 28),
            
            // Type card circle view
            priceCardCircleView.centerYAnchor.constraint(equalTo: priceCardTypeOfPriceView.centerYAnchor),
            priceCardCircleView.leadingAnchor.constraint(equalTo: priceCardTypeOfPriceView.leadingAnchor, constant: 10),
            
            priceCardCircleView.widthAnchor.constraint(equalToConstant: 12),
            priceCardCircleView.heightAnchor.constraint(equalToConstant: 12),
            
            // Type card type of price label
            priceCardTypeOfPriceLabel.centerYAnchor.constraint(equalTo: priceCardCircleView.centerYAnchor),
            priceCardTypeOfPriceLabel.leadingAnchor.constraint(equalTo: priceCardCircleView.trailingAnchor),
            priceCardTypeOfPriceLabel.trailingAnchor.constraint(equalTo: priceCardTypeOfPriceView.trailingAnchor),
            
            // Price card animated circle
            priceCardAnimatedCircle.centerXAnchor.constraint(equalTo: priceCardTypeOfPriceView.centerXAnchor),
            priceCardAnimatedCircle.centerYAnchor.constraint(equalTo: priceCardAmountTextField.centerYAnchor),
            
            priceCardAnimatedCircle.widthAnchor.constraint(equalToConstant: 84),
            priceCardAnimatedCircle.heightAnchor.constraint(equalToConstant: 84),
            
            // MARK: Name card -
            // Name card title lable
            nameCardTitleLabel.topAnchor.constraint(equalTo: priceCardView.bottomAnchor, constant: 16),
            nameCardTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Name card view
            nameCardView.topAnchor.constraint(equalTo: nameCardTitleLabel.bottomAnchor, constant: 10),
            nameCardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameCardView.widthAnchor.constraint(equalToConstant: 370),
            nameCardView.heightAnchor.constraint(equalToConstant: 56),
            
            // Name card text field
            nameCardTextField.centerYAnchor.constraint(equalTo: nameCardView.centerYAnchor),
            nameCardTextField.leadingAnchor.constraint(equalTo: nameCardView.leadingAnchor, constant: 16),
            
            nameCardTextField.widthAnchor.constraint(equalToConstant: 250),
            nameCardTextField.heightAnchor.constraint(equalToConstant: 30),
            
            // Name card SF image
            nameCardSFImage.centerYAnchor.constraint(equalTo: nameCardView.centerYAnchor),
            nameCardSFImage.centerXAnchor.constraint(equalTo: priceCardTypeOfPriceView.centerXAnchor),
            
            nameCardSFImage.widthAnchor.constraint(equalToConstant: 25),
            nameCardSFImage.heightAnchor.constraint(equalToConstant: 25),
            
            // MARK: Category card -
            // Category title lable
            categoryTitleLabel.topAnchor.constraint(equalTo: nameCardView.bottomAnchor, constant: 16),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Category collection view
            categoryCollectionView.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 15),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            // Save button
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -54),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            saveButton.widthAnchor.constraint(equalToConstant: 334),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}
