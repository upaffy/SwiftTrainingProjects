//
//  TabBarViewController.swift
//  ContactList
//
//  Created by Pavlentiy on 08.09.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    let persons = Person.getPersons()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tabBarControllers = viewControllers else { return }
        
        for tabBarController in tabBarControllers {
            guard let navigationVC = tabBarController as? UINavigationController else { return }
            
            if let contactListVC = navigationVC.topViewController as? ContactListViewController {
                contactListVC.persons = persons
            } else if let extendedContactListVC = navigationVC.topViewController as? ExtendedContactListViewController {
                extendedContactListVC.persons = persons
            }
        }
    }
}
