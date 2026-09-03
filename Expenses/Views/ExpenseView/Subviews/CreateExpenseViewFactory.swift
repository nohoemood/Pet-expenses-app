// CreateExpenseViewFactory.swift by mac 31.08.2026

import Foundation
import UIKit

struct CreateExpenseViewFactory {

    static func getLabel(text: String, weight: UIFont.Weight, size: CGFloat, onCenter: Bool) -> UILabel {
        let titleLabel = UILabel()

        titleLabel.text = text
        titleLabel.font = UIFont.systemFont(ofSize: size, weight: weight)
        titleLabel.textColor = UIColor(named: "Title")

        if onCenter {
            titleLabel.textAlignment = .center
        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
    
    static func getCardView(backgroundColor: UIColor, cornerRadius: CGFloat) -> UIView {
        let cardView = UIView()
        
        cardView.backgroundColor = backgroundColor
        
        cardView.layer.cornerRadius = cornerRadius
        
        cardView.layer.borderWidth = 1.0
        cardView.layer.borderColor = UIColor(named: "Stroke")?.cgColor
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }
    
    static func getButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func getTextField(size: CGFloat, weight: UIFont.Weight, numberKeyboard: Bool) -> UITextField {
        let textField = UITextField()

        textField.borderStyle = .none

        textField.textColor = .label
        textField.font = UIFont.systemFont(ofSize: size, weight: weight)
        
        if numberKeyboard {
            textField.keyboardType = .numberPad
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    static func getImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
}
