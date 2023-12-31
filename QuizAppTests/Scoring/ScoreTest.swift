//
//  ScoreTest.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 27/12/2023.
//

import XCTest
@testable import QuizApp

class ScoreTest: XCTestCase {
    func test_noAnswer_scoreZero() {
        XCTAssertEqual(BasicScore.score(for: [String](), comparingTo: [String]()), 0)
    }
    
    func test_oneNonMatchingAnswer_scoreZero() {
        XCTAssertEqual(BasicScore.score(for: ["not a match"], comparingTo: ["an answer"]), 0)
    }
    
    func test_oneMatchingAnswer_scoreOne() {
        XCTAssertEqual(BasicScore.score(for: ["an answer"], comparingTo: ["an answer"]), 1)
    }
    
    func test_oneMatchingOneNonMatchingAnswer_scoreOne() {
        let score = BasicScore.score(
            for: ["an answer","not a match"],
            comparingTo: ["an answer","another answer"])
        XCTAssertEqual(score, 1)
    }
    
    func test_twoMatchingAnswers_scoreTwo() {
        let score = BasicScore.score(
            for: ["an answer","another answer"],
            comparingTo: ["an answer","another answer"])
        XCTAssertEqual(score, 2)
    }
    
    func test_withTooManyAnswers_twoMatchingAnswers_scoreTwo() {
        let score = BasicScore.score(
            for: ["an answer","another answer", "an extra answer"],
            comparingTo: ["an answer","another answer"])
        XCTAssertEqual(score, 2)
    }
    
    func test_withTooManyCorrectAnswers_oneMatchingAnswers_scoreOne() {
        let score = BasicScore.score(
            for: ["not matching","another answer"],
            comparingTo: ["an answer","another answer", "an extra answer"])
        XCTAssertEqual(score, 1)
    }
}
