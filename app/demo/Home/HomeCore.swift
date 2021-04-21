//
//  HomeCore.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import Foundation
import ComposableArchitecture

struct HomeState: Equatable {
    let user: User
    var books: [Book] = []
    var alert: AlertState<HomeAction>?
}

enum HomeAction: Equatable {
    case onAppear
    case homeResponse(Result<[Book], HomeClient.Failure>)
    case preOrder(String)
    case preOrderResponse(Result<String, HomeClient.Failure>)
    case alertDismissed
}

struct HomeEnvironment {
    var homeClient: HomeClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let homeReducer = Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, env in
    struct CancelId: Hashable {}

    switch action {
    case .onAppear:
        return env.homeClient
            .fetch(BooksRequest(userId: state.user.id))
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(HomeAction.homeResponse)

    case let .homeResponse(.failure(error)):
        return .none

    case let .homeResponse(.success(books)):
        state.books = books
        return .none

    case let .preOrder(bookId):
        let userId = state.user.id
        return env.homeClient
            .preorder(PreOrderRequest(userId: state.user.id, bookId: bookId))
            .map { _ in bookId }
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(HomeAction.preOrderResponse)

    case let .preOrderResponse(.failure(error)):
        state.alert = .init(
            title: TextState("Error"),
            message: TextState("Failed to pre-order."),
            dismissButton: .default(TextState("OK"))
        )
        return .none

    case let .preOrderResponse(.success(bookId)):
        if let index = state.books.firstIndex(where: { $0.id == bookId }) {
            var book  = state.books[index]
            book.ordered = true
            state.books[index] = book
        }
        return .none

    case .alertDismissed:
        return .none
    }

}
