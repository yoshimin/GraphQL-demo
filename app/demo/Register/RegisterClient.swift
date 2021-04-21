//
//  RegisterClient.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import Foundation
import ComposableArchitecture

struct RegisterClient {
    enum Failure: Error {
        case duplicated
        case internalError
    }

    var register: (UserRequest) -> Effect<User, Failure>
}

extension RegisterClient {
    static let live = RegisterClient(register: { request in
        return GraphQLMutationPublisher(request: request)
            .tryMap {
                if let error = $0.errors?.first {
                    let classification = error.extensions?["classification"] as? String
                    switch classification {
                    case "ALREADY_EXISTS":
                        throw Failure.duplicated
                    default:
                        throw Failure.internalError
                    }
                }
                guard let user = $0.data?.registerUser else {
                    throw Failure.internalError
                }
                return user
            }
            .mapError {
                switch $0 {
                case is Failure:
                    return $0 as! Failure
                default:
                    return .internalError
                }
            }
            .eraseToEffect()
    })

    static let mock = RegisterClient(register: { _ in
        return Effect(value: User(id: "1", name: "ichika"))
    })
}
