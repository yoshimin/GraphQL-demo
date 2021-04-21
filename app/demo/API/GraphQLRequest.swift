//
//  GraphQLRequest.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/16.
//

import Foundation
import Apollo

protocol GraphQLRequest {
    associatedtype Operation: GraphQLOperation

    var url: URL { get }
    var operation: Operation { get }
}

protocol GraphQLQueryRequest: GraphQLRequest where Operation == Query {
    associatedtype Query: GraphQLQuery
}

protocol GraphQLMutationRequest: GraphQLRequest where Operation == Mutation {
    associatedtype Mutation: GraphQLMutation
}

extension GraphQLRequest {
    var url: URL {
        return URL(string: "http://192.168.10.108:8080/graphql")!
    }
}
