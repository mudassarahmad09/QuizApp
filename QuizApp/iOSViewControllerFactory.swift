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
        switch question {
        case .single(let value):
            return QuestionViewController(question: value, options: options[question]!, selection: answerCallbacK) 
        case .multiple(let t):
            return UIViewController()
        }

    }
    
    func resultViewController(for result: Resulte<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
