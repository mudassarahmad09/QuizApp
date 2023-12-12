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
        factory.stub(question: Question.single("Q1"), with: viewController)
        factory.stub(question: Question.single("Q2"), with: secondviewController)
        
        sut.routeTo(question: Question.single("Q1"), answerCallback: {_ in })
        sut.routeTo(question: Question.single("Q2"), answerCallback: {_ in })
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondviewController)
    }
    
    func test_routerToQuestion_presentQuestionControllerWithRightCallback() {
        var callbackWasFired = false
        sut.routeTo(question: Question.single("Q1"), answerCallback: {_ in  callbackWasFired = true})
        factory.answerCallback[Question.single("Q1")]!("anything")
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routerToResult_showsResultController() {

        let viewController =  UIViewController()
        let result = Resulte(answer: [Question.single("Q1"): "A1"], score: 10)
        
        let secondViewController =  UIViewController()
        let secondResult = Resulte(answer: [Question.single("Q2"): "A2"], score: 20)
        
        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)
        
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)

    }
    
    class NoneAnimatedNavigationContorller: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub:  ViewCotrollerFactory {
        
        private var stubQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubResults = Dictionary<Resulte<Question<String>, String>, UIViewController>()
        var answerCallback = Dictionary<Question<String>, (String) -> (Void)>()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubQuestions[question] = viewController
        }
        
        func stub(result: Resulte<Question<String>, String>, with viewController: UIViewController) {
            stubResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallbacK: @escaping (String) -> (Void)) -> UIViewController {
            self.answerCallback[question] = answerCallbacK
            return stubQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for result: Resulte<Question<String>, String>) -> UIViewController {
            stubResults[result] ?? UIViewController()
        }
    }
}
