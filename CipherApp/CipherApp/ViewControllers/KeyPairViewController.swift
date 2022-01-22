//
//  KeyPairViewController.swift
//  CipherApp
//
//  Created by Pavlentiy on 19.09.2021.
//

import UIKit

class KeyPairViewController: UIViewController {
    @IBOutlet var publicKeyTF: UITextField!
    @IBOutlet var privateKeyTF: UITextField!
    
    var algorithm: Algorithm!
    
    var publicKey = (0, 0)
    var privateKey = (0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton(to: publicKeyTF, privateKeyTF)
    }
    
    @IBAction func generateKeyPairButtonPressed() {
        guard let rsa = algorithm.algorithmClass as? RSA else { return }
        
        (publicKey, privateKey, _) = rsa.generateKeyPair(using: 11, and: 19)
        
        publicKeyTF.text = "\(publicKey.0).\(publicKey.1)"
        privateKeyTF.text = "\(privateKey.0).\(privateKey.1)"
    }
    
    @IBAction func doneButtonPressed() {
        
        // alert
        let keyPairAlert = UIAlertController(
            title: "ooops",
            message: "check the correctness of the entered data" ,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        keyPairAlert.addAction(okAction)

        // Public
        guard let publicKeyComponents = publicKeyTF.text?.components(separatedBy: ".") else {
            present(keyPairAlert, animated: true)
            return
        }
        
        if publicKeyComponents.count != 2 {
            present(keyPairAlert, animated: true)
        }
        
        publicKey = (Int(publicKeyComponents[0]) ?? 0, Int(publicKeyComponents[1]) ?? 0)
        
        // Private
        guard let privateKeyComponents = privateKeyTF.text?.components(separatedBy: ".") else {
            present(keyPairAlert, animated: true)
            return
        }
        
        if privateKeyComponents.count != 2 {
            present(keyPairAlert, animated: true)
        }
        
        privateKey = (Int(privateKeyComponents[0]) ?? 0, Int(privateKeyComponents[1]) ?? 0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let messageVC = segue.destination as? MessageViewController else { return }
        messageVC.privateKey = privateKey
        messageVC.publicKey = publicKey
        messageVC.algorithm = algorithm
    }
    
}

// MARK: - working with keyboard
extension KeyPairViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func addDoneButton(to textFields: UITextField...) {
        for textField in textFields {
            let keypadToolbar = UIToolbar()
            
            let flexSpace = UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: nil,
                action: nil
            )
            
            let doneButton = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: textField,
                action: #selector(UITextField.resignFirstResponder)
            )
            
            keypadToolbar.items = [flexSpace, doneButton]

            keypadToolbar.sizeToFit()
            textField.inputAccessoryView = keypadToolbar
        }
    }
}
