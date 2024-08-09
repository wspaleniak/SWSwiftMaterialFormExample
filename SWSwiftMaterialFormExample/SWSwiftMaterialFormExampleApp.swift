//
//  SWSwiftMaterialFormExampleApp.swift
//  SWSwiftMaterialFormExample
//
//  Created by Wojciech Spaleniak on 08/08/2024.
//

import SwiftUI

@main
struct SWSwiftMaterialFormExampleApp: App {
    var body: some Scene {
        WindowGroup {
            FormView(viewModel: FormViewModel())
        }
    }
}
