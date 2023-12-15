//
//  ResulteHelper.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 15/12/2023.
//

@testable import QuizEngine

extension Resulte: Hashable {
    static func make(answer: [Question : Answer] = [:], score: Int = 0) -> Resulte<Question, Answer> {
        Resulte(answer: answer, score: score)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
    }
    
    public static func == (lhs: Resulte<Question, Answer>, rhs: Resulte<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
        
    }
}
