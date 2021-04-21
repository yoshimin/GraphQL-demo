//
//  RootView.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<RootState, RootAction>

    @ViewBuilder var body: some View {
        IfLetStore(
            store.scope(
                state: { $0.register },
                action: RootAction.register
            )
        ) { store in
            NavigationView {
                RegisterView(store: store)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }

        IfLetStore(
            store.scope(
                state: { $0.home },
                action: RootAction.home
            )
        ) { store in
            NavigationView {
                HomeView(store: store)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

