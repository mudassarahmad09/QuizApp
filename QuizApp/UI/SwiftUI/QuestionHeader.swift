//
//  QuestionHeader.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 28/12/2023.
//

import SwiftUI

struct QuestionHeader: View {
    let title: String
    let question: String
    
    var body: some View {
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
    }
}
#Preview {
    QuestionHeader(title: "A title", question: "A question")
        .previewLayout(.sizeThatFits)
}
