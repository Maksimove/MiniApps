//
//  ResultViewController.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 07.09.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Public properties
    var answers: [Answer]!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }
    // MARK: - IBActions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
    // MARK: - Setup result
extension ResultViewController {
    private func updateResult() {
        var frequencyOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        let sortedFrequentOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequentAnimal = sortedFrequentOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequentAnimal)
    }
    private func updateUI(with animal: Animal) {
        resultLabel.text = "Вы \(animal.rawValue)"
        descriptionLabel.text = animal.definition
    }
}
