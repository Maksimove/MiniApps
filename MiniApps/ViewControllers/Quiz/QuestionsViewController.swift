//
//  QuestionsViewController.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 07.09.2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var questionProgressView: UIProgressView!
    @IBOutlet var questionlabel: UILabel!
    
    @IBOutlet var singleAnswerStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleAnswerStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedAnswerStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    // MARK: - Private properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answerChoosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        let answersCount = Float(currentAnswers.count - 1)
        rangedSlider.maximumValue = answersCount
        rangedSlider.value = answersCount / 2
    }
    // MARK: - Data transfer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.answers = answerChoosen
    }
    //MARK: - IBActions
    @IBAction func singleAnswerPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answerChoosen.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer ) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answerChoosen.append(currentAnswers[index])
        nextQuestion()
    }
}
    //MARK: - Setup UI
private extension QuestionsViewController {
    func updateUI() {
        for stackView in [
            singleAnswerStackView,
            multipleAnswerStackView,
            rangedAnswerStackView
        ] {
            stackView?.isHidden = true
        }
        setupNavigationBar()
        let currentQuestion = questions[questionIndex]
        questionlabel.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    func setupNavigationBar() {
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        let navBarApearance = UINavigationBarAppearance()
        navBarApearance.backgroundColor = .systemMint
        navBarApearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarApearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApearance
    }
    
    func showCurrentAnswers(for type: ResponceType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .range: showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleAnswerStackView.isHidden.toggle()
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleAnswerStackView.isHidden.toggle()
        for(label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangedAnswerStackView.isHidden.toggle()
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
