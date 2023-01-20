//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Елена Логинова on 16.01.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet var resultLebel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    //MARK: - Properties
    
    var answerChosen: [Answer]!
    private var result: AnimalType!
    
    //MARK: - Ovveride Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        summarizing()
        resultLebel.text = "Вы - \(result.rawValue)"
        descriptionLabel.text = result.definition
    }

    //MARK: - IBActions

    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ResultViewController {
    private func summarizing() {
        
        let animals = answerChosen.map { $0.type }
        var countAnimals: [AnimalType: Int] = [:]
        
        for animal in animals {
            countAnimals[animal, default: 0] += 1
        }
        
        result = countAnimals.sorted { $0.value > $1.value }.first?.key
    }
}
