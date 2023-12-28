//
//  ViewCotrollerFactory.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//
import UIKit
import QuizEngine

protocol ViewCotrollerFactory {
    typealias Answer = [(question: Question<String>, answer: [String])]
    func questionViewController(for question: Question<String>, answerCallbacK: @escaping ([String]) -> (Void)) -> UIViewController
    
    func resultViewController(for userAnswers: Answer) -> UIViewController
    
    func resultViewController(for result: Resulte<Question<String>, [String]>) -> UIViewController
}
