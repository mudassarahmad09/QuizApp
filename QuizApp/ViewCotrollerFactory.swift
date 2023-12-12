//
//  ViewCotrollerFactory.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//
import UIKit
import QuizEngine

protocol ViewCotrollerFactory {
    func questionViewController(for question: Question<String>, answerCallbacK: @escaping ([String]) -> (Void)) -> UIViewController
    
    func resultViewController(for result: Resulte<Question<String>, [String]>) -> UIViewController
}
