//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 13/12/2023.
//

import QuizEngine

final class ResultsPresenter {
    typealias Answer = [(question: Question<String>, answer: [String])]
    typealias Scorer = ([[String]], [[String]]) -> Int
    
    private let userAnswers: Answer
    private let correctAnswers: Answer
    private let scorer: Scorer
        
    init(userAnswers: Answer, correctAnswers: Answer, scorer: @escaping Scorer) {
        self.userAnswers = userAnswers
        self.correctAnswers = correctAnswers
        self.scorer = scorer
    }
    
    var title: String {
        "Result"
    }
    
    var summary: String {
        "You got \(score)/\(userAnswers.count) correct"
    }
    
    var score: Int {
        scorer(userAnswers.map { $0.answer }, correctAnswers.map { $0.answer })
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return zip(userAnswers, correctAnswers).map { userAnswer, correctAnswer in
            return presentableAnswer(userAnswer.question, userAnswer.answer, correctAnswer.answer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .single(let value), .multiple(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                worngAnswer: formattedWrongAnswer(userAnswer, correctAnswer)
            )
        }
    }
    
    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
         correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
    
    private func formattedAnswer(_ answers: [String]) -> String {
        answers.joined(separator: ", ")
    }
}
