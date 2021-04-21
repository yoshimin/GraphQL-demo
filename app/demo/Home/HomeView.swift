//
//  HomeView.swift
//  demo
//
//  Created by Shingai Yoshimi on 2021/04/20.
//

import SwiftUI
import ComposableArchitecture

extension Book: Identifiable {}

struct HomeView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List(viewStore.books) { book in
                ZStack(alignment: .leading) {
                    HomeRow(book: book, onClick: {
                        viewStore.send(.preOrder($0))
                    })
                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .alert(
                self.store.scope(state: { $0.alert }),
                dismiss: .alertDismissed
            )
            .onAppear { viewStore.send(.onAppear) }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store(
            initialState: HomeState(user: User.init(id: "1", name: "ichika")),
            reducer: homeReducer,
            environment: HomeEnvironment(
                homeClient: .mock,
                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
            )
        ))
        .previewDevice("iPhone 11")
    }
}
