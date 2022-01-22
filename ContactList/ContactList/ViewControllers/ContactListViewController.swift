//
//  ContactListViewController.swift
//  ContactList
//
//  Created by Pavlentiy on 08.09.2021.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    var persons: [Person]!

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonName", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = persons[indexPath.row].fullName
        
        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let personInfoVC = segue.destination as? PersonInfoViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        personInfoVC.person = persons[indexPath.row]
    }
}
