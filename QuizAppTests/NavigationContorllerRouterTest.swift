//
//  NavigationContorllerRouterTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

class NavigationContorllerRouterTest: XCTestCase {
    
    let navigationController = NoneAnimatedNavigationContorller()
    let factory = ViewControllerFactoryStub()
    lazy var sut = {
        NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    func test_routerToQuestions_showsQuestionController() {

        let viewController =  UIViewController()
        let secondviewController =  UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondviewController)
        
        sut.routeTo(question: "Q1", answerCallback: {_ in })
        sut.routeTo(question: "Q2", answerCallback: {_ in })
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondviewController)
    }
    
    func test_routerToQuestion_presentQuestionControllerWithRightCallback() {
        var callbackWasFired = false
        sut.routeTo(question: "Q1", answerCallback: {_ in  callbackWasFired = true})
        factory.answerCallback["Q1"]!("anything")
        XCTAssertTrue(callbackWasFired)
    }
    
    class NoneAnimatedNavigationContorller: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub:  ViewCotrollerFactory {
        
        private var stubQuestions = [String: UIViewController]()
        var answerCallback = [String: (String) -> (Void)]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubQuestions[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallbacK: @escaping (String) -> (Void)) -> UIViewController {
            self.answerCallback[question] = answerCallbacK
            return stubQuestions[question] ?? UIViewController()
        }
    }
}
