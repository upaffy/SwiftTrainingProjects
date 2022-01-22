//
//  ViewController.swift
//  LoginApp
//
//  Created by Pavlentiy on 25.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    // MARK: - Private Properties
    private let password = "qwerty"
    private let userName = "User"
    
    // MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        
        guard let viewControllers = tabBarController.viewControllers else { return }
        
        for viewController in viewControllers {
            if let welcomeVC = viewController as? WelcomeViewController {
                welcomeVC.userName = userNameTF.text
            } else if let navigationController = viewController as? UINavigationController {
                let aboutUserVC = navigationController.topViewController as! AboutUserViewController
                aboutUserVC.title = userNameTF.text
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func remindRegisterData(_ sender: UIButton) {
        sender.tag == 0
            ? showAlert(title: "Hint", body: "Your name is \(userName) 😉")
            : showAlert(title: "Hint", body: "Your password is \(password) 🤫")
    }
    
    @IBAction func loginButtonPressed() {
        if userNameTF.text != userName || passwordTF.text != password {
            passwordTF.text = ""
            showAlert(title: "Oooops", body: "Invalid login or password")
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        userNameTF.text = ""
        passwordTF.text = ""
    }
}

// MARK: - Private Methods
extension LoginViewController {
    private func showAlert(title: String, body: String) {
        let alert = UIAlertController(
            title: title,
            message: body,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

// MARK: - Keyboard Methods
extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else {
            loginButtonPressed()
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
        return true
    }
}

