//
//  HomeRow.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import SwiftUI
import ComposableArchitecture

struct HomeRow: View {
    let book: Book
    let onClick: (String) -> Void

    private var buttonTitle: String {
        return book.ordered ? "予約済み" : "予約"
    }
    private var buttonColor: Color {
        return book.ordered ? .gray : .blue
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(book.name)
                    .font(.headline)
                Text(book.price)
                    .font(.subheadline)
            }
            Spacer()
            Button(action: {
                onClick(book.id)
            }, label: {
                Text(buttonTitle)
                    .foregroundColor(buttonColor)
                    .frame(width: 120, height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonColor, lineWidth: 1)
                    )
            })
            .disabled(book.ordered)
        }

        .padding(.vertical, 6)
        .padding(.horizontal, 16)
    }
}

struct HomeRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeRow(book: Book(id: "1", name: "SwiftUI Projects", price: "¥2,919", ordered: false), onClick: {_ in})
        .frame(width: 500)
        .previewLayout(.sizeThatFits)

        HomeRow(book: Book(id: "1", name: " SwiftUI Essentials ", price: "¥4,386", ordered: true), onClick: {_ in})
        .frame(width: 500)
        .previewLayout(.sizeThatFits)
    }
}

