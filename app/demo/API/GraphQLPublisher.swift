//
//  GraphQLPublisher.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/16.
//

import Foundation
import Combine
import Apollo

struct GraphQLQueryPublisher<Request: GraphQLQueryRequest>: Publisher {
    typealias Output = GraphQLResult<Request.Query.Data>

    typealias Failure = Error

    let request: Request

    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = Subscription(request: request) { result in
            switch result {
            case let .success(result):
                _ = subscriber.receive(result)
            case let .failure(error):
                subscriber.receive(completion: .failure(error))
            }
        }
        subscriber.receive(subscription: subscription)
    }

    private class Subscription: Combine.Subscription {
        var combineIdentifier = CombineIdentifier()

        private var client: ApolloClient?
        private var cancellable: Apollo.Cancellable?

        init(request: Request, resultHandler: GraphQLResultHandler<Request.Query.Data>? = nil) {
            client = ApolloClient(url: request.url)
            cancellable = client?.fetch(query: request.operation, resultHandler: resultHandler)
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            self.cancellable?.cancel()
        }
    }
}

struct GraphQLMutationPublisher<Request: GraphQLMutationRequest>: Publisher {
    typealias Output = GraphQLResult<Request.Mutation.Data>

    typealias Failure = Error

    let request: Request

    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = Subscription(request: request) { result in
            switch result {
            case let .success(result):
                _ = subscriber.receive(result)
            case let .failure(error):
                subscriber.receive(completion: .failure(error))
            }
        }
        subscriber.receive(subscription: subscription)
    }


    private class Subscription: Combine.Subscription {
        var combineIdentifier = CombineIdentifier()

        private var client: ApolloClient?
        private var cancellable: Apollo.Cancellable?

        init(request: Request, resultHandler: GraphQLResultHandler<Request.Mutation.Data>? = nil) {
            client = ApolloClient(url: request.url)
            cancellable = client?.perform(mutation: request.operation, resultHandler: resultHandler)
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func cancel() {
            self.cancellable?.cancel()
        }
    }
}
