//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewCotrollerFactory {
    
    typealias Answer = [(question: Question<String>, answers: [String])]
    
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    private let correctAnswer: () -> Answer
    
    init(options: [Question<String>: [String]], correctAnswer: Answer) {
        self.questions = correctAnswer.map { $0.question }
        self.options = options
        self.correctAnswer = { correctAnswer }
    }
    
    init(question: [Question<String>], options: [Question<String>: [String]], correctAnswer: [Question<String>: [String]]) {
        self.questions = question
        self.options = options
        self.correctAnswer = { question.map { question in
                (question, correctAnswer[question]!)
            }
        }
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
            return questionViewControler(for: question, value: value, options: options, allowsMultipleSelection: false, answerCallbacK: answerCallbacK)
        case .multiple(let value):
            return questionViewControler(for: question, value: value, options: options, allowsMultipleSelection: true, answerCallbacK: answerCallbacK)
        }
    }
    
    private func questionViewControler(for question: Question<String>,value: String, options: [String],allowsMultipleSelection: Bool, answerCallbacK: @escaping ([String]) -> (Void)) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller =  QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallbacK)
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(for result: Resulte<Question<String>, [String]>) -> UIViewController {
        let preseenter =  ResultsPresenter(
            userAnswers: questions.map { question in
            (question, result.answer[question]!)
        },
            correctAnswers: correctAnswer(),
            scorer: { _,_  in result.score})
        
       let controller =  ResultViewController(summary: preseenter.summary, answer: preseenter.presentableAnswers)
        controller.title = preseenter.title
        return controller
    }
}
