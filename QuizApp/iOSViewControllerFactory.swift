//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewCotrollerFactory {
    private let options: [Question<String>: [String]]
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallbacK: @escaping ([String]) -> (Void)) -> UIViewController {
        guard let options = options[question] else { 
            fatalError("Couldn't find the options for the question: \(question)")
        }
        return questionViewControleer(for : question, options: options, answerCallbacK: answerCallbacK)
    }
    
    private func questionViewControleer(for question: Question<String>, options: [String], answerCallbacK: @escaping ([String]) -> (Void)) -> UIViewController {
        switch question {
        case .single(let value):
            let controller =  QuestionViewController(question: value, options: options, selection: answerCallbacK)
            controller.title = "Question #1"
            return controller
        case .multiple(let value):
            let controller =  QuestionViewController(question: value, options: options, selection: answerCallbacK)
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }
    
    func resultViewController(for result: Resulte<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
