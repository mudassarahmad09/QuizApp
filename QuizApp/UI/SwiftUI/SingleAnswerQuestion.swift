//
//  SingleAnswerQuestion.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 28/12/2023.
//

import SwiftUI

struct SingleAnswerQuestion: View {
    let title: String
    let question: String
    let options: [String]
    let selection: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            QuestionHeader(title: title, question: question)
            
            ForEach(options, id: \.self) { option in
                singleTextSelectionCell(text: option, selection: {})
            }
            
            Spacer()
        }
    }
}

#Preview {
    SingleAnswerQuestion(
        title: "1 of 2",
        question: "What is Qazi Nationality?",
        options: [
            "Pakistan",
            "India",
            "USA",
            "Canadian"
        ],
        selection: {_ in})
}
