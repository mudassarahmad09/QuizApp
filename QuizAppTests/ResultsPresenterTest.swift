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
    
    let singleAnswerQuestion = Question.single("Q1")
    let multipleAnswerQuestion = Question.multiple("Q2")
    
    func test_summay_withTwoQuestionAndScoreOne_returnSummary() {
        let answer = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2", "A3"]]
        let resulte = Resulte(answer: answer, score: 1)
        let orderQuestion = [singleAnswerQuestion, multipleAnswerQuestion]
        let sut = ResultsPresenter(
            resulte: resulte,
            question: orderQuestion,
            correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answer = Dictionary<Question<String>, [String]>()
        let resulte = Resulte(answer: answer, score: 0)
        let sut = ResultsPresenter(
            resulte: resulte,
            question: [],
            correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWorngSingleAnswer_mapAnswer() {
        let userAnswer = [singleAnswerQuestion: ["A1"]]
        let correctAnswers = [singleAnswerQuestion: ["A2"]]
        let resulte = Resulte(answer: userAnswer, score: 0)
        let sut = ResultsPresenter(
            resulte: resulte,
            question: [singleAnswerQuestion],
            correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first?.worngAnswer, "A1")
    }
    
    func test_presentableAnswers_withWorngMultipleAnswer_mapMutipleAnswers() {
        let userAnswer = [multipleAnswerQuestion: ["A1","A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"]]
        let resulte = Resulte(answer: userAnswer, score: 0)
        let sut = ResultsPresenter(
            resulte: resulte,
            question: [multipleAnswerQuestion],
            correctAnswers: correctAnswers)
         
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.worngAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withTwoMultipleAnswer_mapOrderedAnswers() {
        let userAnswer = [singleAnswerQuestion: ["A2"], multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [singleAnswerQuestion: ["A2"], multipleAnswerQuestion: ["A1", "A4"]]
        let orderQuestion = [singleAnswerQuestion,multipleAnswerQuestion]
        
        let resulte = Resulte(answer: userAnswer, score: 0)
        let sut = ResultsPresenter(resulte: resulte, question: orderQuestion, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2")
        XCTAssertNil(sut.presentableAnswers.first?.worngAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.last?.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last?.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.last?.worngAnswer)
    }
}
