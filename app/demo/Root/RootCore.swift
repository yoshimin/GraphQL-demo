//
//  RootCore.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import Foundation
import ComposableArchitecture

struct RootState: Equatable {
    var register:  RegisterState? = RegisterState()
    var home: HomeState?
}

enum RootAction: Equatable {
    case register(RegisterAction)
    case home(HomeAction)
}

struct RootEnvironment {
    var registerClient: RegisterClient
    var homeClient: HomeClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    registerReducer
        .optional()
        .pullback(
            state: \.register,
            action: /RootAction.register,
            environment: {
                RegisterEnvironment(registerClient: $0.registerClient, mainQueue: $0.mainQueue)
            }
        ),
    homeReducer
        .optional()
        .pullback(
            state: \.home,
            action: /RootAction.home,
            environment: {
                HomeEnvironment(homeClient: $0.homeClient, mainQueue: $0.mainQueue)
            }
        ),
    Reducer { state, action, _ in
        switch action {
        case let .register(.registerResponse(.success(user))):
            state.home = HomeState(user: user)
            state.register = nil
            return .none

        case .register:
          return .none

        case .home:
            return .none
        }
    }
)
