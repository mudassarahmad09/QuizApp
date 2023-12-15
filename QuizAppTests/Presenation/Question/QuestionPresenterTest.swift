//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 14/12/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    
    let question1 = Question.single("A1")
    let question2 = Question.multiple("A2")
    
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatsTitleForIndex() {

        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistentQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [], question: Question.single("A1"))
        XCTAssertEqual(sut.title, "")
    }
    
}
