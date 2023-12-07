//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 07/12/2023.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WorngAnswerCell: UITableViewCell {
    
}

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
    }
}
// MARK: -
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        let cell =  answer.isCorrect ? CorrectAnswerCell(): WorngAnswerCell()
        return cell
    }
}
