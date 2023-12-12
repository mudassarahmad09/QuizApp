//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
@testable import QuizApp

class QuestionTest: XCTestCase {
    func test_hashValue_singleAnswer_returnTypeHash() {
        let type = "a String"
        let sut = Question.single(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnTypeHash() {
        let type = "a String"
        let sut = Question.multiple(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equal_isEqual() {
        XCTAssertEqual(Question.single("a String"), Question.single("a String"))
        XCTAssertEqual(Question.multiple("a String"), Question.multiple("a String"))
    }
    
    func test_notEqual_isNotEqual() {
        XCTAssertNotEqual(Question.single("a String"), Question.single("an other String"))
        XCTAssertNotEqual(Question.multiple("a String"), Question.multiple("an other String"))
        
        XCTAssertNotEqual(Question.single("a String"), Question.multiple("an other String"))
        XCTAssertNotEqual(Question.single("a String"), Question.multiple("a String"))
    }
    
}
