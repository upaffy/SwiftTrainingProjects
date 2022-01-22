//
//  ExtendedContactListViewController.swift
//  ContactList
//
//  Created by Pavlentiy on 08.09.2021.
//

import UIKit

class ExtendedContactListViewController: UITableViewController {
    let rowsInSection = 2
    
    var persons: [Person]!

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        persons.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsInSection
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfo", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let sectionNumber = indexPath.section
        
        if indexPath.row == 0 {
            content.image = UIImage(systemName: "phone")
            content.text = persons[sectionNumber].phoneNumber
        } else {
            content.image = UIImage(systemName: "envelope")
            content.text = persons[sectionNumber].email
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        persons[section].fullName
    }
}
