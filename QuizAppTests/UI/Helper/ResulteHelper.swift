//
//  ResulteHelper.swift
//  QuizAppTests
//
//  Created by Qazi Mudassar on 15/12/2023.
//

@testable import QuizEngine

extension Resulte {
    static func make(answer: [Question : Answer] = [:], score: Int = 0) -> Resulte<Question, Answer> {
        Resulte(answer: answer, score: score)
    }
}
extension Resulte: Equatable where Answer: Equatable {
    public static func == (lhs: Resulte<Question, Answer>, rhs: Resulte<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answer == rhs.answer
        
    }
}
extension Resulte: Hashable where Answer: Hashable  {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
        hasher.combine(answer)
    }
}
