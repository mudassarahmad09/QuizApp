//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

class NavigationContorllerRouterTest: XCTestCase {
    func test_answerForQuestions_showsQuestionController() {

        let viewController =  UIViewController()
        let secondviewController =  UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondviewController)
        
        sut.answer(for: singleAnswerQuestion, completion: {_ in })
        sut.answer(for: multipleAnswerQuestion, completion: {_ in })
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondviewController)
    }
    
    func test_answerForQuestion_singleAnswer_answerCallBack_progressToNextQuestion() {
        var callbackWasFired = false
        sut.answer(for: singleAnswerQuestion, completion: {_ in  callbackWasFired = true})
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_answerForQuestion_multipleAnswer_answerCallBack_doesNotProgressToNextQuestion() {
        var callbackWasFired = false
        sut.answer(for: multipleAnswerQuestion, completion: {_ in  callbackWasFired = true})
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertFalse(callbackWasFired)
    }
    
    func test_answerForQuestion_multipleAnswer_configuerViewControllerWithSubmitButton() {
        let viewController =  UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.answer(for: multipleAnswerQuestion, completion: {_ in })
        
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_answerForQuestion_singleAnswer_doesNotConfiguerViewControllerWithSubmitButton() {
        let viewController =  UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        sut.answer(for: singleAnswerQuestion, completion: {_ in })
        
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_answerForQuestion_multipleAnswerSubmitButton_isDisableWhenZeroAnswerSelected() {
        let viewController =  UIViewController()
        
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.answer(for: multipleAnswerQuestion, completion: {_ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_answerForQuestion_multipleAnswerSubmitButton_progressToNextQuestion() {
        let viewController =  UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        var callbackWasFired = false
        sut.answer(for: multipleAnswerQuestion, completion: {_ in  callbackWasFired = true})
        
        viewController.navigationItem.rightBarButtonItem!.simulateTap()
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_didCompleteQuiz_showsResultController() {

        let viewController =  UIViewController()
        let userAnswers = [(singleAnswerQuestion, ["A1"])]
        
        let secondViewController =  UIViewController()
        let seconduserAnswers = [(multipleAnswerQuestion, ["A2"])]
        
        factory.stub(resultForQuestions: [singleAnswerQuestion], with: viewController)
        factory.stub(resultForQuestions: [multipleAnswerQuestion], with: secondViewController)
        
        sut.didCompleteQuiz(withAnswers: userAnswers)
        sut.didCompleteQuiz(withAnswers: seconduserAnswers)
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)

    }
    
    // MARK: - Helper
    
    private let singleAnswerQuestion = Question.single("Q1")
    private let multipleAnswerQuestion = Question.multiple("Q2")
    
    private let navigationController = NoneAnimatedNavigationContorller()
    private let factory = ViewControllerFactoryStub()
    
    private lazy var sut = {
        NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    private class NoneAnimatedNavigationContorller: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    private class ViewControllerFactoryStub:  ViewCotrollerFactory {
        
        private var stubQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubResults = Dictionary<[Question<String>], UIViewController>()
        var answerCallback = Dictionary<Question<String>, ([String]) -> (Void)>()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubQuestions[question] = viewController
        }
        
        func stub(resultForQuestions questions: [Question<String>], with viewController: UIViewController) {
            stubResults[questions] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallbacK: @escaping ([String]) -> (Void)) -> UIViewController {
            self.answerCallback[question] = answerCallbacK
            return stubQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for userAnswers: Answer) -> UIViewController {
            stubResults[userAnswers.map { $0.question }] ?? UIViewController()
        }
    }
}
private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
