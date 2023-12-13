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
        let sut = ResultsPresenter(resulte: resulte)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_summay_withThreeQuestionAndScoreTwo_returnSummary() {
        let answer = [Question.single("Q1"): ["A1"],
                      Question.multiple("Q2"): ["A2", "A3"],
                      Question.multiple("Q3"): ["A3"]]
        let resulte = Resulte(answer: answer, score: 2)
        let sut = ResultsPresenter(resulte: resulte)
        XCTAssertEqual(sut.summary, "You got 2/3 correct")
    }
}
