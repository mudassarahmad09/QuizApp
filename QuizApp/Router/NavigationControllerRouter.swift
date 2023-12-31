//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import UIKit
import QuizEngine

final class NavigationControllerRouter: QuizDeleget {
    
    private let navigationController: UINavigationController
    private let factory: ViewCotrollerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewCotrollerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func answer(for question: Question <String>, completion: @escaping ([String]) -> Void) {
        switch question {
        case .single:
            show(factory.questionViewController(for: question, answerCallbacK: completion))
        case .multiple:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = SubmitButtonController(button, completion)
            let controller = factory.questionViewController(for: question, answerCallbacK: { selection in
                buttonController.update(selection)
            })

            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
    }
        
    func didCompleteQuiz(withAnswers answers: [(question: Question<String>, answer: [String])]) {
        show(factory.resultViewController(for: answers))
    }
            
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callBack: ([String])-> Void
    private var model: [String] = []
    
    init(_ button: UIBarButtonItem, _ callBack: @escaping ([String]) -> Void) {
        self.button = button
        self.callBack = callBack
        super.init()
        self.setUp()
    }
    
    private func setUp() {
        button.target = self
        button.action = #selector(firesCallBack)
        updateButtonState()
    }
    
    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }
    
    @objc private func firesCallBack() {
        callBack(model)
    }
}
