//
//  RegisterCore.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import SwiftUI
import ComposableArchitecture

extension UserMutation.Data.RegisterUser: Equatable {
    public static func == (lhs: UserMutation.Data.RegisterUser, rhs: UserMutation.Data.RegisterUser) -> Bool {
        lhs.id == rhs.id
    }
}
typealias User = UserMutation.Data.RegisterUser

struct RegisterState: Equatable {
    var name: String = ""
    var email: String = ""
    var isValidInput: Bool = false
    var alert: AlertState<RegisterAction>?
}

enum RegisterAction: Equatable {
    case nameChanged(String)
    case emailChanged(String)
    case registerButtonTapped
    case registerResponse(Result<User, RegisterClient.Failure>)
    case alertDismissed
}

struct RegisterEnvironment {
  var registerClient: RegisterClient
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

let registerReducer = Reducer<RegisterState, RegisterAction, RegisterEnvironment> { state, action, env in
    func isValidInput() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: state.email) && state.name.count > 0
    }

    switch (action) {
    case let .nameChanged(name):
        state.name = name
        state.isValidInput = isValidInput()
        return .none

    case let .emailChanged(email):
        state.email = email
        state.isValidInput = isValidInput()
        return .none

    case .registerButtonTapped:
        return env.registerClient
            .register(UserRequest(name: state.name, email: state.email))
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(RegisterAction.registerResponse)

    case let .registerResponse(.failure(error)):
        state.alert = .init(
            title: TextState("Error"),
            message: TextState(error.message),
            dismissButton: .default(TextState("OK"))
        )
        return .none

    case let .registerResponse(.success(user)):
        return .none

    case .alertDismissed:
        return .none
    }
}

private extension RegisterClient.Failure {
    var message: LocalizedStringKey {
        switch self {
        case .duplicated: return "Already exists."
        case .internalError: return "Register failed."
        }
    }
}
