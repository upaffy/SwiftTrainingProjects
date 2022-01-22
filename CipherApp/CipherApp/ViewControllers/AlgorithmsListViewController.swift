//
//  AlgorithmsListViewController.swift
//  CipherApp
//
//  Created by Pavlentiy on 18.09.2021.
//

import UIKit

class AlgorithmsListViewController: UITableViewController {
    let algorithmList = Algorithm.getAlgorithms()
    
    override func viewDidLoad() {
        let apologiesAlert = UIAlertController(
            title: "Sorry🥺",
            message: "Russian language is not supported yet\nOnly a message in English can be encrypted" ,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        apologiesAlert.addAction(okAction)
        
        present(apologiesAlert, animated: false)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        algorithmList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlgorithmType", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = algorithmList[indexPath.row].name
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let algorithm = algorithmList[indexPath.row]
        if indexPath.row == 0 {
            performSegue(withIdentifier: "GenerateKeyPairSegue", sender: algorithm)
        } else {
            performSegue(withIdentifier: "StartEncryptionSegue", sender: algorithm)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let keyPairVC = segue.destination as? KeyPairViewController {
            keyPairVC.algorithm = sender as? Algorithm
        } else if let messageVC = segue.destination as? MessageViewController {
            messageVC.algorithm = sender as? Algorithm
        }
    }
}
