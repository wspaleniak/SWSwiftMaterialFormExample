//
//  FormViewModel.swift
//  SWSwiftMaterialFormExample
//
//  Created by Wojciech Spaleniak on 08/08/2024.
//

import SwiftUI
import SWSwiftMaterialForm

@Observable
final class FormViewModel {
    
    // MARK: - Form
    
    /// ???
    var unfocusFields: Bool = false
    
    /// Whether the form has any field with an error state.
    var hasErrors: Bool = false
    
    /// The array of fields indexes with an error state.
    var erroredFields: [Int] = []
    
    /// The background color of the form.
    @ObservationIgnored
    let backgroundColor: Color = .init(uiColor: .systemBackground)
    
    // MARK: - Fields
    
    /// The text of the name field.
    var nameText: String = ""
    
    /// The text of the email field.
    var emailText: String = ""
    
    /// The text of the password field.
    var passwordText: String = ""
    
    /// ???
    @ObservationIgnored
    let animals: [String] = ["Dog", "Cat", "Fish", "Snake", "Tiger", "Lion"]
}
