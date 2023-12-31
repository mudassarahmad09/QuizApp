//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

class iOSUIKitViewControllerFactoryTest: XCTestCase {
    
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
    
    func test_resultViewController_createControllerWithTitle() {
        let results = makeReulst()
        XCTAssertEqual(results.controller.title, results.presenter.title)
    }
    
    func test_resultViewController_createControllerWithSummary() {
        let results = makeReulst()
        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultViewController_createControllerWithPresentableAnswers() {
        let results = makeReulst()
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }
    
    // MARK: Helper
    func makeSUT(options: [Question<String>: [String]] = [:],
                 correctAnswer: [(Question<String>, [String])] = []) -> iOSUIKitViewControllerFactory {
        iOSUIKitViewControllerFactory(options: options, correctAnswer: correctAnswer)
    }
    
    func makeQuestionViewController(question: Question<String> = Question.single("")) -> QuestionViewController {
        let sut = makeSUT(
            options: [question: options],
            correctAnswer: [(singleAnswerQuestion, []), (multipleAnswerQuestion, [])])
        return sut.questionViewController(for: question, answerCallbacK: {_ in }) as! QuestionViewController
    }
    
    func makeReulst() -> (controller: ResultViewController, presenter: ResultsPresenter) {
        let userAnswer = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1", "A2"])]
        let correctAnswer = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1", "A2"])]
        
        let presenter = ResultsPresenter(
            userAnswers: userAnswer,
            correctAnswers: correctAnswer,
            scorer: BasicScore.score
        )
        
        let sut = makeSUT(correctAnswer: correctAnswer)
        let controller = sut.resultViewController(for: userAnswer) as! ResultViewController
        return (controller ,presenter)
    }
}
