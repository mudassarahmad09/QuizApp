//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 13/12/2023.
//

import QuizEngine

struct ResultsPresenter {
    let resulte: Resulte<Question<String>, [String]>
    let question: [Question<String>]
    let correctAnswers: Dictionary<Question<String>, [String]>
    
    var title: String {
        "Result"
    }
    
    var summary: String {
        "You got \(resulte.score)/\(resulte.answer.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        question.map { question in
            guard let userAnswer = resulte.answer[question],
                  let correctAnswer = correctAnswers[question] else {
                fatalError("could not find the correct answer for the question \(question)")
            }
            return presentableAnswer( question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .single(let value), .multiple(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                worngAnswer: formattedWorngAnswer(userAnswer, question)
            )
        }
    }
    
    private func formattedWorngAnswer(_ userAnswer: [String], _ question: Question<String>) -> String? {
        userAnswer == correctAnswers[question] ? nil : formattedAnswer(userAnswer)
    }
    
    private func formattedAnswer(_ answers: [String]) -> String {
        answers.joined(separator: ", ")
    }
}
