//
//  demoApp.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/13.
//

import SwiftUI
import ComposableArchitecture

@main
struct demoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(
                initialState: RootState(),
                reducer: rootReducer.debug(),
                environment: RootEnvironment(
                    registerClient: .live,
                    homeClient: .live,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            ))
        }
    }
}
