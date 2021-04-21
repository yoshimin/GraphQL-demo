//
//  Requests.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/16.
//

import Foundation

struct UserRequest: GraphQLMutationRequest {
    typealias Mutation = UserMutation

    let name: String
    let email: String

    var operation: Mutation {
        return UserMutation(name: name, email: email)
    }
}

struct BooksRequest: GraphQLQueryRequest {
    typealias Query = BooksQuery

    let userId: String

    var operation: Query {
        return BooksQuery(userId: userId)
    }
}

struct PreOrderRequest: GraphQLMutationRequest {
    typealias Mutation = PreOrderMutation

    let userId: String
    let bookId: String

    var operation: Mutation {
        return PreOrderMutation.init(userId: userId, bookId: bookId)
    }
}
