//
//  MessageViewController.swift
//  CipherApp
//
//  Created by Pavlentiy on 20.09.2021.
//

import UIKit

class MessageViewController: UIViewController {
    @IBOutlet var algorithmNameLabel: UILabel!
    @IBOutlet var messageTF: UITextField!
    @IBOutlet var encryptSC: UISegmentedControl!
    
    var publicKey = (0, 0)
    var privateKey = (0, 0)
    
    var algorithm: Algorithm!
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        algorithmNameLabel.text = algorithm.name
    }
    
    @IBAction func resultButtonPressed(_ sender: Any) {
        let messageAlert = UIAlertController(
            title: "ooops",
            message: "check the correctness of the entered data" ,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        messageAlert.addAction(okAction)
        
        switch encryptSC.selectedSegmentIndex {
        case 0:
            if let atbash = algorithm.algorithmClass as? Atbash {
                result = atbash.encryption(message: messageTF.text ?? "")
                
                performSegue(withIdentifier: "resultSegue", sender: nil)
            } else if let vigenere = algorithm.algorithmClass as? Vigenere {
                result = vigenere.encryption(message: messageTF.text ?? "")
                
                performSegue(withIdentifier: "resultSegue", sender: nil)
            } else if let rsa = algorithm.algorithmClass as? RSA {
                let cipherInts = rsa.encrypt(messageTF.text ?? "", with: publicKey)
                let cipherText = cipherInts.map { String($0) }
                
                result = cipherText.joined(separator: " ")
                performSegue(withIdentifier: "resultSegue", sender: nil)
            }
            
        default:
            if let atbash = algorithm.algorithmClass as? Atbash {
                result = atbash.decryption(cipherText: messageTF.text ?? "")
                
                performSegue(withIdentifier: "resultSegue", sender: nil)
            } else if let vigenere = algorithm.algorithmClass as? Vigenere {
                result = vigenere.decrypt(message: messageTF.text ?? "")
                
                performSegue(withIdentifier: "resultSegue", sender: nil)
            } else if let rsa = algorithm.algorithmClass as? RSA {
                
                let strings = (messageTF.text ?? "").components(separatedBy: " ")
                
                if strings.count == 0 {
                    present(messageAlert, animated: true)
                }
                
                let ints = strings.map { Int($0) ?? 1 }
                print(ints)
                
                result = rsa.decrypt(ints, with: privateKey)
                
                performSegue(withIdentifier: "resultSegue", sender: nil)
            }
        }
    }
    
       
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.result = result
    }

}

// MARK: - UITextFieldDelegate
extension MessageViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

