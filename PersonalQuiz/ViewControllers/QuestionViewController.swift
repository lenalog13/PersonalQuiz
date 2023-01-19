//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Елена Логинова on 16.01.2023.
//

import UIKit

final class QuestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var questionLable: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLables: [UILabel]!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    // MARK: - Private Properties
    
    private let questions = Question.getQuestions()
    private var answerChosen: [Answer] = []
    private var questionIndex = 0
    
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    //MARK: - Override Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVS = segue.destination as? ResultViewController else {return}
        resultVS.answerChosen = answerChosen
    }
    
    // MARK: - IBActions
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else {return}
        let currentAnswer = currentAnswers[currentIndex]
        answerChosen.append(currentAnswer)
        nextQuesrion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multiple, answer) in zip(multipleSwitches, currentAnswers){
            if multiple.isOn {
                answerChosen.append(answer)
            }
        }
        nextQuesrion()
    }
    
    @IBAction func rengedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        nextQuesrion()
    }
    
}

    // MARK: - User Interface

extension QuestionViewController {
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        
        title = "Вопрос №\(questionIndex + 1) из \(questions.count)"
        questionLable.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        showCurrentAnswers(for: currentQuestion.type)
    
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLables.first?.text = answers.first?.title
        rangedLables.last?.text = answers.last?.title
    }
    
    private func nextQuesrion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }
    
}


