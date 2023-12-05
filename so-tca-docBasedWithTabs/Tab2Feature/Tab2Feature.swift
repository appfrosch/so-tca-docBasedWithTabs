//
//  Tab2Feature.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 05.12.2023.
//

import ComposableArchitecture
import Foundation

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

