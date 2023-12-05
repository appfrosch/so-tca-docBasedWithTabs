//
//  Tab2View.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 05.12.2023.
//

import ComposableArchitecture
import SwiftUI

// MARK: Tab2View
struct Tab2View: View {
  let store: StoreOf<Tab2Feature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TextEditor(text: viewStore.$text)
    }
  }
}
