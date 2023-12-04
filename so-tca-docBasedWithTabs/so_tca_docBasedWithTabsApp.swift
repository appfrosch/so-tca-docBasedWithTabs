//
//  so_tca_docBasedWithTabsApp.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 04.12.2023.
//

import SwiftUI

@main
struct so_tca_docBasedWithTabsApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: so_tca_docBasedWithTabsDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
