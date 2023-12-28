//
//  singleTextSelectionCell.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 28/12/2023.
//

import SwiftUI

struct singleTextSelectionCell: View {
    let text: String
    let selection: () -> Void
    var body: some View {
        Button(action: selection, label: {
            HStack {
                Circle()
                    .stroke(Color.secondary, lineWidth: 2.5)
                    .frame(width: 30.0, height: 30.0)
                
                Text(text)
                    .font(.title)
                    .foregroundStyle(Color.secondary)
                
                Spacer()
            }.padding()
        })
    }
}

#Preview {
    singleTextSelectionCell(text: "A Text", selection: {})
        .previewLayout(.sizeThatFits)
}
