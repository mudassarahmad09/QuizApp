//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import UIKit
import QuizEngine

protocol ViewCotrollerFactory {
    func questionViewController(for question: Question<String>, answerCallbacK: @escaping (String) -> (Void)) -> UIViewController
    func resultViewController(for result: Resulte<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewCotrollerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewCotrollerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallbacK: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(result: Resulte<Question<String>, String>) {
    
        let viewController = factory.resultViewController(for: result)
        navigationController.pushViewController(viewController, animated: true)
    }
}
