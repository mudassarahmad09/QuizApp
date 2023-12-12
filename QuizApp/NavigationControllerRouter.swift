//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewCotrollerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewCotrollerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question <String>, answerCallback: @escaping ([String]) -> Void) {
        show(factory.questionViewController(for: question, answerCallbacK: answerCallback))
    }
    
    func routeTo(result: Resulte<Question<String>, [String]>) {
        show(factory.resultViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
