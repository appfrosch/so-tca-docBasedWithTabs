//
//  so_tca_docBasedWithTabsApp.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 04.12.2023.
//

import ComposableArchitecture
import SwiftUI

@main
struct so_tca_docBasedWithTabsApp: App {
  var body: some Scene {
    DocumentGroup(newDocument: so_tca_docBasedWithTabsDocument()) { file in
      AppView(document: file.$document, store: createStore(with: file.document.text))
    }
  }

  func createStore(with text: String) -> StoreOf<AppFeature> {
    Store(
      initialState: AppFeature.State(text: "Hello, world!")) {
      AppFeature()
    }
  }
}
