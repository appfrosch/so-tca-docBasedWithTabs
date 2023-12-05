//
//  AppView.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 05.12.2023.
//

import ComposableArchitecture
import SwiftUI

// MARK: AppView
struct AppView: View {
  @Binding var document: so_tca_docBasedWithTabsDocument
  let store: StoreOf<AppFeature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TabView(
        selection: viewStore.binding(
          get: { $0.selectedTab },
          send: AppFeature.Action.setTabTo
        )
      ) {
        Tab1View(
          store: self.store.scope(
            state: \.tab1,
            action: AppFeature.Action.tab1
          )
        )
        .tabItem { Text("Tab1") }
        .tag(AppFeature.Tab.tab1)

        Tab2View(
          store: self.store.scope(
            state: \.tab2,
            action: AppFeature.Action.tab2
          )
        )
        .padding()
        .tabItem { Text("Tab2") }
        .tag(AppFeature.Tab.tab2)
      }
      .bind(viewStore.$text, to: $document.text)
    }
  }
}

#Preview {
  AppView(
    document: .constant(so_tca_docBasedWithTabsDocument()),
    store: Store(initialState: AppFeature.State(text: "")) {
      AppFeature()
    })
}

