//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import UIKit
import QuizEngine

protocol ViewCotrollerFactory {
    func questionViewController(for question: String, answerCallbacK: @escaping (String) -> (Void)) -> UIViewController
}

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewCotrollerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewCotrollerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallbacK: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(result: Result<String, String>) {
    
    }
}
