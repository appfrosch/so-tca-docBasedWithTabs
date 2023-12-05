//
//  Tab1View.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 05.12.2023.
//

import ComposableArchitecture
import SwiftUI

// MARK: Tab1View
struct Tab1View: View {
  let store: StoreOf<Tab1Feature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading) {
        Text("Editing disabled")
        TextEditor(text: .constant(viewStore.$text.wrappedValue))
          .padding()
        Button("Change to tab 2") {
          viewStore.send(.delegate(.setTabTo(.tab2)))
        }
      }
      .padding()
    }
  }
}
