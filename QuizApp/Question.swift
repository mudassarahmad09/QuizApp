//
//  Question.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import Foundation

enum Question<T: Hashable>: Hashable{
    case single(T)
    case multiple(T)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .single(let t), .multiple(let t):
            hasher.combine(t)
        }
    }
    
    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.single(let a), .single(let b)):
           return a == b
        case (.multiple(let a) , .multiple(let b)):
            return  a == b
        default:
            return false
        }
    }
}
