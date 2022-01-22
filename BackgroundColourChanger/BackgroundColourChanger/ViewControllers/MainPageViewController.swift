//
//  MainPageViewController.swift
//  BackgroundColourChanger
//
//  Created by Pavlentiy on 05.09.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func changeMainBackgroundColor(to color: UIColor)
}

class MainPageViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.delegate = self
        settingsVC.mainScreenColor = view.backgroundColor
    }
}

extension MainPageViewController: SettingsViewControllerDelegate {
    func changeMainBackgroundColor(to color: UIColor) {
        view.backgroundColor = color
    }
}
