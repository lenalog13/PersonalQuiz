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
    
    //MARK: - Private Properties
    
    
    //MARK: - Ovveride Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: - IBActions

    @IBAction func doneButtonPressed(_ sender: Any) {
    }
}
