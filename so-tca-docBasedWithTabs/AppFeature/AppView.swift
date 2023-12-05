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

  init(
    document: Binding<so_tca_docBasedWithTabsDocument>
  ) {
    self._document = document
    self.store = Store(
      initialState: AppFeature.State(
        text: document.wrappedValue.text,
        selectedTab: .tab1
      )
    ) {
      AppFeature()
    }
  }

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TabView(selection: viewStore.$selectedTab) {
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
  AppView(document: .constant(so_tca_docBasedWithTabsDocument()))
}

