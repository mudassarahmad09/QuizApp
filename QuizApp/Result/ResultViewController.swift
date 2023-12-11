//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 07/12/2023.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var summary: String = ""
    private var answers: [PresentableAnswer] = [PresentableAnswer]()
    
    convenience init(summary: String, answer: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        headerLabel.text = summary
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WorngAnswerCell.self)
    }
}
// MARK: -
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.worngAnswer == nil {
            return correctAnswerCell(for: answer)
        }
        return worngAnswerCell(for: answer)
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func worngAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WorngAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.corretAnswerLabel.text = answer.answer
        cell.worngAnswerLabel.text = answer.worngAnswer
        return cell
    }
}
