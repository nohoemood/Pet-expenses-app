// PriceTextFieldDelegate.swift by mac 01.09.2026

import Foundation
import UIKit

class PriceTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var onTextChanged: ((String) -> Void)?

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let isNumeric = allowedCharacters.isSuperset(of: characterSet)
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        onTextChanged?(updatedText)
        return isNumeric && updatedText.count <= 5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
