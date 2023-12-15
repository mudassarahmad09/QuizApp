//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

class NavigationContorllerRouterTest: XCTestCase {
    let singleAnswerQuestion = Question.single("Q1")
    let multipleAnswerQuestion = Question.multiple("Q2")
    
    let navigationController = NoneAnimatedNavigationContorller()
    let factory = ViewControllerFactoryStub()
    lazy var sut = {
        NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    func test_routerToQuestions_showsQuestionController() {

        let viewController =  UIViewController()
        let secondviewController =  UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondviewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: {_ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in })
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondviewController)
    }
    
    func test_routerToQuestion_singleAnswer_answerCallBack_progressToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: singleAnswerQuestion, answerCallback: {_ in  callbackWasFired = true})
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routerToQuestion_multipleAnswer_answerCallBack_doesNotProgressToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in  callbackWasFired = true})
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertFalse(callbackWasFired)
    }
    
    func test_routerToQuestion_multipleAnswer_configuerViewControllerWithSubmitButton() {
        let viewController =  UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in })
        
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routerToQuestion_singleAnswer_doesNotConfiguerViewControllerWithSubmitButton() {
        let viewController =  UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        sut.routeTo(question: singleAnswerQuestion, answerCallback: {_ in })
        
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routerToQuestion_multipleAnswerSubmitButton_isDisableWhenZeroAnswerSelected() {
        let viewController =  UIViewController()
        
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routerToQuestion_multipleAnswerSubmitButton_progressToNextQuestion() {
        let viewController =  UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in  callbackWasFired = true})
        
        let button = viewController.navigationItem.rightBarButtonItem!
        button.simulateTap()
                
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routerToResult_showsResultController() {

        let viewController =  UIViewController()
        let result = Resulte(answer: [singleAnswerQuestion: ["A1"]], score: 10)
        
        let secondViewController =  UIViewController()
        let secondResult = Resulte(answer: [multipleAnswerQuestion: ["A2"]], score: 20)
        
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
        private var stubResults = Dictionary<Resulte<Question<String>, [String]>, UIViewController>()
        var answerCallback = Dictionary<Question<String>, ([String]) -> (Void)>()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubQuestions[question] = viewController
        }
        
        func stub(result: Resulte<Question<String>, [String]>, with viewController: UIViewController) {
            stubResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallbacK: @escaping ([String]) -> (Void)) -> UIViewController {
            self.answerCallback[question] = answerCallbacK
            return stubQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for result: Resulte<Question<String>, [String]>) -> UIViewController {
            stubResults[result] ?? UIViewController()
        }
    }
}
private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
