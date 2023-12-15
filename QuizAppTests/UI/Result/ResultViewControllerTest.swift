//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 07/12/2023.
//

import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "A Summary").headerLabel.text, "A Summary")
    }
    
    func test_viewDidLoad_withOutAnswer_doesNotRenderAnswer() {
        XCTAssertEqual(makeSUT(answer: []).tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneAnswer_renderOneAnswer() {
        let sut = makeSUT(answer: [makeAnswer()])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
        
    func test_viewDidLoad_withCorrectAnswers_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answer: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
        
    func test_viewDidLoad_withWorngAnswers_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1",worngAnswer: "worng")
        let sut = makeSUT(answer: [answer])
        let cell = sut.tableView.cell(at: 0) as? WorngAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.corretAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.worngAnswerLabel.text, "worng")
    }
    
    // MARK: Helper
    func makeSUT(summary: String = "", answer: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary,answer: answer)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question: String = "", answer: String = "",worngAnswer: String? = nil) -> PresentableAnswer {
        PresentableAnswer(question: question, answer: answer, worngAnswer: worngAnswer)
    }
}
