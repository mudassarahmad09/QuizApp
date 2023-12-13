//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: Question.single("Q1")).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createControllerWithOption() {
        XCTAssertEqual(makeQuestionViewController(question: Question.single("Q1")).options, options)
    }
    
    func test_questionViewController_singleAnswer_createControllerWithSingleSelection() {
        let controller = makeQuestionViewController(question: Question.single("Q1"))
        _ = controller.view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: Question.multiple("Q1")).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithOption() {
        XCTAssertEqual(makeQuestionViewController(question: Question.multiple("Q1")).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithMultipleSelection() {
        let controller = makeQuestionViewController(question: Question.multiple("Q1"))
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helper
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionViewController(question: Question<String> = Question.single("")) -> QuestionViewController {
         makeSUT(options: [question: options]).questionViewController(for: question, answerCallbacK: {_ in }) as! QuestionViewController
    }
}
