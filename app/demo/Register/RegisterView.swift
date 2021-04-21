//
//  RegisterView.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import SwiftUI
import ComposableArchitecture

struct RegisterView: View {
    struct ViewState: Equatable {
        var name: String
        var email: String
        var isButtonDisabled: Bool
        var buttonColor: Color
    }

    let store: Store<RegisterState, RegisterAction>

    var body: some View {
        WithViewStore(store.scope(state: { $0.view })) { viewStore in
            VStack {
                TextField(
                    "name",
                    text: viewStore.binding(get: { $0.name }, send: RegisterAction.nameChanged)
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

                TextField(
                    "email",
                    text: viewStore.binding(get: { $0.email }, send: RegisterAction.emailChanged)
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

                Button(action: {
                    viewStore.send(.registerButtonTapped)
                }, label: {
                    Text("Go")
                        .foregroundColor(viewStore.buttonColor)
                        .frame(width: 120, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewStore.buttonColor, lineWidth: 1)
                        )
                })
                .disabled(viewStore.isButtonDisabled)
                .padding(.top, 30)
            }
            .alert(
                self.store.scope(state: { $0.alert }),
                dismiss: .alertDismissed
            )
        }
    }
}

extension RegisterState {
  var view: RegisterView.ViewState {
    RegisterView.ViewState(
        name: name,
        email: email,
        isButtonDisabled: !isValidInput,
        buttonColor: isValidInput ? .blue : .gray
    )
  }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(store: Store(
            initialState: RegisterState(),
            reducer: registerReducer,
            environment: RegisterEnvironment(
                registerClient: .mock,
                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
            )
        ))
    }
}

