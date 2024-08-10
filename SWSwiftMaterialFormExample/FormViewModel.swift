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
    
    /// The ID of the focused field.
    var focusedFieldID: Int? = nil
    
    /// If some field in the container is focused, it allows to hide the keyboard.
    var unfocusFields: Bool = false
    
    /// Whether the form has any field with an error state.
    var hasErrors: Bool = false
    
    /// The array of fields indexes with an error state.
    var erroredFields: [Int] = []
    
    /// The background color of the form.
    @ObservationIgnored
    let backgroundColor: Color = .init(uiColor: .systemBackground)
    
    // MARK: - Fields
    
    /// The style for all fields.
    var configuration: SWFieldStyleConfiguration = .underlineShadow
    
    /// The text of the name field.
    var nameText: String = ""
    
    /// The custom validator for the name field.
    @ObservationIgnored
    let nameValidator: SWCustomValidator = { text in
        switch text.count {
        case 1..<3: .error(message: "Your name is too short...")
        case 3...5: .error(message: "Give us more letters bro xd")
        default: .ok
        }
    }
    
    /// The text of the email field.
    var emailText: String = ""
    
    /// The text of the password field.
    var passwordText: String = ""
    
    /// The index of the selected animal from the animal picker.
    var animalSelection: Int? = nil
    
    /// The array for the animal picker.
    @ObservationIgnored
    let animals: [String] = [
        "Dog", "Cat", "Fish", "Snake", "Tiger", "Lion", "Turtle"
    ]
    
    /// The text of the age field.
    var ageText: String = ""
    
    /// The text of the hour field.
    var hourDate: String? = nil
    
    /// The text of the birthday field.
    var birthdayDate: String? = nil
    
    /// The text of the notes field.
    var notesText: String = ""
    
    /// The text of the additional info field.
    var infoText: String = ""
}
