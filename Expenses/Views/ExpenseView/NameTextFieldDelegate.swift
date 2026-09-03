// NameTextFieldDelegate.swift by mac 02.09.2026 

import Foundation
import UIKit

class NameTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var onTextChanged: ((String) -> Void)?

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        onTextChanged?(updatedText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
