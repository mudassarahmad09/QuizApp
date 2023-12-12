//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    func test_questionViewController_createControllerWithQuestion() {
        
        let question = Question.single("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: Question.single("Q1"), answerCallbacK: {_ in }) as? QuestionViewController
        XCTAssertEqual(controller?.question, "Q1")
    }
    
    func test_questionViewController_createControllerWithOption() {
        
        let question = Question.single("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: question, answerCallbacK: {_ in }) as? QuestionViewController
        
        XCTAssertEqual(controller?.options, options)
    }
}
