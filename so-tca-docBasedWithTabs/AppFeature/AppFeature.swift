//
//  AppFeature.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 05.12.2023.
//

import ComposableArchitecture
import Foundation

// MARK: AppFeature
@Reducer
struct AppFeature {
  enum Tab {
    case tab1, tab2
  }

  struct State: Equatable {
    @BindingState var text: String
    var selectedTab: Tab

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

      case .tab1(.delegate(.setTabTo(let tab))):
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
    ._printChanges()
  }
}

