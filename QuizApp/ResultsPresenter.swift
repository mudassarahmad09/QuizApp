//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 13/12/2023.
//

import QuizEngine

struct ResultsPresenter {
    private let resulte: Resulte<Question<String>, [String]>
    
    var summary: String {
        "You got \(resulte.score)/\(resulte.answer.count) correct"
    }
    
    init(resulte: Resulte<Question<String>, [String]>) {
        self.resulte = resulte
    }
    
}
