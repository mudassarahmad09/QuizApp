//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let singleAnswerQuestion = Question.single("Q1")
    let multipleAnswerQuestion = Question.multiple("Q1")
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createControllerWithTitle() {

        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createControllerWithOption() {
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionViewController(question: singleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithOption() {
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithMultipleSelection() {
        XCTAssertTrue(makeQuestionViewController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_resultViewController_createController() {
        let resulte = Resulte(answer: Dictionary<Question<String>, [String]>() , score: 0)
        let sut = makeSUT(options: [:])
        let controller = sut.resultViewController(for: resulte) as! ResultViewController
        XCTAssertNotNil(controller)
    }
    
    // MARK: Helper
    func makeSUT( options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        iOSViewControllerFactory(question: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
    }
    
    func makeQuestionViewController(question: Question<String> = Question.single("")) -> QuestionViewController {
         makeSUT(options: [question: options]).questionViewController(for: question, answerCallbacK: {_ in }) as! QuestionViewController
    }
}
