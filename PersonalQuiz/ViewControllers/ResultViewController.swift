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
        let catCount = answerChosen.filter { $0.type == .cat }.count
        let dogCount = answerChosen.filter { $0.type == .dog }.count
        let rabbitCount = answerChosen.filter { $0.type == .rabbit }.count
        let tartleCount = answerChosen.filter { $0.type == .turtle }.count
        
        if catCount >= dogCount, catCount >= rabbitCount, catCount >= tartleCount {
            result = .cat
        } else if dogCount >= rabbitCount, dogCount >= tartleCount {
            result = .dog
        } else if rabbitCount >= tartleCount {
            result = .rabbit
        } else {
            result = .turtle
        }
    }
}
