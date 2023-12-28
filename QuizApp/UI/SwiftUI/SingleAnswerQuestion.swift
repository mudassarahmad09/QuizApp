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
            
            VStack(alignment: .leading, spacing: 15) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.blue)
                    .padding(.top)
                
                Text(question)
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }.padding()
            
            ForEach(options, id: \.self) { option in
                Button(action: {}, label: {
                    HStack {
                        Circle()
                            .stroke(Color.secondary, lineWidth: 2.5)
                            .frame(width: 30.0, height: 30.0)
                        
                        Text(option)
                            .font(.title)
                            .foregroundStyle(Color.secondary)
                        
                        Spacer()
                    }.padding()
                })
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