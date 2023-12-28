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
                singleTextSelectionCell(text: option, selection: {
                    selection(option)
                })
            }
            
            Spacer()
        }
    }
}

#Preview {
    let testOnlyView = SingleAnswerQuestionTestView()
    return testOnlyView
    struct SingleAnswerQuestionTestView: View {
        @State var selection = ""
        
        var body: some View {
            VStack {
                SingleAnswerQuestion(
                    title: "1 of 2",
                    question: "What is Qazi Nationality?",
                    options: [
                        "Pakistan",
                        "India",
                        "USA",
                        "Canadian"
                    ],
                    selection: { selection = $0 })
            }
            Text("Last selection" + selection)
        }
    }
}
