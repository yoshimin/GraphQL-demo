//
//  HomeClient.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import Foundation
import ComposableArchitecture

struct Book: Equatable {
    let id: String
    let name: String
    let price: String
    var ordered: Bool
}

struct HomeClient {
    enum Failure: Error {
        case internalError
    }

    var fetch: (BooksRequest) -> Effect<[Book], Failure>
    var preorder: (PreOrderRequest) -> Effect<String, Failure>
}

extension HomeClient {
    static let live = HomeClient(
        fetch: { request in
        return GraphQLQueryPublisher(request: request)
            .map {
                let books = $0.data?.getAllBook.compactMap{ $0 } ?? []
                let preOrdered = $0.data?.getPreOrderedBooks.compactMap{ $0 }

                return books.map { book in
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    formatter.currencyCode = "JPY"

                    return Book(
                        id: book.id,
                        name: book.name,
                        price: formatter.string(from: NSNumber(value: book.price)) ?? "-",
                        ordered: preOrdered?.contains(where: { $0.id == book.id }) ?? false
                    )
                }
            }
            .mapError { _ in .internalError }
            .eraseToEffect()
    },
        preorder: { request in
        return GraphQLMutationPublisher(request: request)
            .tryMap {
                guard let orderId = $0.data?.preOrder?.id else {
                    throw Failure.internalError
                }
                return orderId
            }
            .mapError { _ in .internalError }
            .eraseToEffect()
    }
    )

    static let mock = HomeClient(
        fetch: { _ in
            return Effect(value: [])
        },
        preorder: { _ in
            return Effect(value: "1")
        }
    )
}
