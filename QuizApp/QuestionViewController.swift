//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var question = ""
    private var options = [String]()
    private let reuseIdentifier = "Cell"
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        headerLabel.text = question
    }
}
extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell
    }
}
