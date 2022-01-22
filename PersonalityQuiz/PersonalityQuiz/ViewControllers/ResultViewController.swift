//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Alexey Efimov on 30.08.2021.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        let mostFrequentAnimal = findFrequentAnimal()
        
        resultLabel.text = "Вы - \(mostFrequentAnimal.rawValue)"
        descriptionLabel.text = mostFrequentAnimal.definition
    }
    
    private func findFrequentAnimal() -> Animal {
        let countedAnimals = answers.reduce(into: [:]) {
            counts, answer in counts[answer.animal, default: 0] += 1
        }
        
        let mostFrequent = countedAnimals.sorted { $0.value > $1.value }
        
        return mostFrequent.first?.key ?? Animal.dog
    }
}
