//
//  ResultsPresenterTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 13/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp
class ResultsPresenterTest: XCTestCase {
    
    func test_summay_withTwoQuestionAndScoreOne_returnSummary() {
        let answer = [Question.single("Q1"): ["A1"],
                      Question.multiple("Q2"): ["A2", "A3"]]
        let resulte = Resulte(answer: answer, score: 1)
        let sut = ResultsPresenter(resulte: resulte, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answer = Dictionary<Question<String>, [String]>()
        let resulte = Resulte(answer: answer, score: 0)
        let sut = ResultsPresenter(resulte: resulte, correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWorngSingleAnswer_mapAnswer() {
        let userAnswer = [Question.single("Q1"): ["A1"]]
        let correctAnswers = [Question.single("Q1"): ["A2"]]
        let resulte = Resulte(answer: userAnswer, score: 0)
        let sut = ResultsPresenter(resulte: resulte, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first?.worngAnswer, "A1")
    }
    
    func test_presentableAnswers_withWorngMultipleAnswer_mapMutipleAnswers() {
        let userAnswer = [Question.multiple("Q1"): ["A1","A4"]]
        let correctAnswers = [Question.multiple("Q1"): ["A2", "A3"]]
        let resulte = Resulte(answer: userAnswer, score: 0)
        let sut = ResultsPresenter(resulte: resulte, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.worngAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withRightSingleAnswer_mapAnswer() {
        let userAnswer = [Question.single("Q1"): ["A1"]]
        let correctAnswers = [Question.single("Q1"): ["A1"]]
        let resulte = Resulte(answer: userAnswer, score: 1)
        let sut = ResultsPresenter(resulte: resulte, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.worngAnswer)
    }
    
    func test_presentableAnswers_withRightMultipleAnswer_mapMutipleAnswers() {
        let userAnswer = [Question.multiple("Q1"): ["A2", "A3"]]
        let correctAnswers = [Question.multiple("Q1"): ["A2", "A3"]]
        let resulte = Resulte(answer: userAnswer, score: 0)
        let sut = ResultsPresenter(resulte: resulte, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2, A3")
        XCTAssertNil(sut.presentableAnswers.first?.worngAnswer)
    }
}
