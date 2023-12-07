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
    
    func test_viewDidLoad_withCorrectAnswers_renderCorrectAnswerCell() {
        let sut = makeSUT(answer: [PresentableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWorngAnswers_renderWorngAnswerCell() {
        let sut = makeSUT(answer: [PresentableAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WorngAnswerCell
        XCTAssertNotNil(cell)
    }
    
    // MARK: Helper
    func makeSUT(summary: String = "", answer: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary,answer: answer)
        _ = sut.view
        return sut
    }
    
    func makeAnswer() -> PresentableAnswer   {
        PresentableAnswer(isCorrect: false)
    }
}
