//
//  PersonInfoViewController.swift
//  ContactList
//
//  Created by Pavlentiy on 08.09.2021.
//

import UIKit

class PersonInfoViewController: UIViewController {

    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        fullNameLabel.text = person.fullName
        phoneLabel.text = "Phone: \(person.phoneNumber)"
        emailLabel.text = "Email: \(person.email)"
    }
    
    // return the tab bar back
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            tabBarController?.tabBar.isHidden = false
        }
    }
}
