//
//  ResultViewController.swift
//  CipherApp
//
//  Created by Pavlentiy on 20.09.2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = result
    }
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true)
    }
}
