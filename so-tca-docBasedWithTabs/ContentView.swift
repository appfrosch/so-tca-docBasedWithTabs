//
//  ContentView.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 04.12.2023.
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

// MARK: AppFeature
@Reducer
struct AppFeature {
  enum Tab {
    case tab1, tab2
  }

  struct State: Equatable {
    @BindingState var text: String
    @BindingState var selectedTab: Tab

    var tab1: Tab1Feature.State
    var tab2: Tab2Feature.State

    init(
      text: String,
      selectedTab: Tab = .tab1
    ) {
      self.text = text
      self.selectedTab = selectedTab
      self.tab1 = .init(text: text)
      self.tab2 = .init(text: text)
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)

    case setTabTo(Tab)

    case tab1(Tab1Feature.Action)
    case tab2(Tab2Feature.Action)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case let .setTabTo(tab):
        state.selectedTab = tab
        return .none

      case .tab1, .tab2:
        return .none
      }
    }
    Scope(
      state: \.tab1,
      action: /Action.tab1
    ) {
      Tab1Feature()
    }
    Scope(
      state: \.tab2,
      action: /Action.tab2
    ) {
      Tab2Feature()
    }
  }
}

// MARK: Tab1Feature
@Reducer
struct Tab1Feature {
  struct State: Equatable {
    @BindingState var text: String
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      }
    }
  }
}

// MARK: Tab1View
struct Tab1View: View {
  let store: StoreOf<Tab1Feature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading) {
        Text("Editing disabled")
        TextEditor(text: viewStore.$text)
          .disabled(true)
          .padding()
      }
      .padding()
    }
  }
}

// MARK: Tab2Feature
@Reducer
struct Tab2Feature {
  struct State: Equatable {
    @BindingState var text: String
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      }
    }
  }
}

// MARK: Tab2View
struct Tab2View: View {
  let store: StoreOf<Tab2Feature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TextEditor(text: viewStore.$text)
    }
  }
}
