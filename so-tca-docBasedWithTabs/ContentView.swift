//
//  ContentView.swift
//  so-tca-docBasedWithTabs
//
//  Created by Andreas Seeger on 04.12.2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: so_tca_docBasedWithTabsDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(so_tca_docBasedWithTabsDocument()))
}
