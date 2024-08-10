//
//  FormView.swift
//  SWSwiftMaterialFormExample
//
//  Created by Wojciech Spaleniak on 08/08/2024.
//

import SwiftUI
import SWSwiftMaterialForm

struct FormView: View {
    
    // MARK: - Properties
    
    /// The view model of the form.
    @Bindable
    private(set) var viewModel: FormViewModel
    
    /// The spacing in the form between fields.
    @ScaledMetric
    private var spacing: CGFloat = 20.0

    // MARK: - Body
    
    var body: some View {
        ScrollView {
            HStack {
                info
                changeStyleButton
            }
            form
            nextButton
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .onTapGesture { viewModel.unfocusFields = true }
    }
    
    // MARK: - Subviews
    
    private var form: some View {
        SWContainer(
            spacing: spacing,
            errors: $viewModel.hasErrors
        ) {
            topSection
            middleSection
            bottomSection
        }
        .containerStyle(.startWithFocusedFieldAfter, 0)
        .containerStyle(.focusedFieldID, $viewModel.focusedFieldID)
        .containerStyle(.unfocusFields, $viewModel.unfocusFields)
        .containerStyle(.erroredFields, $viewModel.erroredFields)
        .containerStyle(.backgroundColor, viewModel.backgroundColor)
        .containerStyle(.animation, .bouncy)
        .containerStyle(.toolbarFont, .headline)
        .containerStyle(.toolbarTintColor, .indigo)
    }
    
    private var topSection: some View {
        VStack(spacing: spacing) {
            Text("Login")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
            
            SWTextField(
                title: "Your name",
                text: $viewModel.nameText
            )
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.required, .required(message: "Tell us your name please :)"))
            .fieldStyle(.customValidator, viewModel.nameValidator)
            .fieldStyle(.limitText, 12)
            .fieldStyle(.extraView, AnyView(nameExtraView))
            
            SWTextField(
                title: "Your email",
                text: $viewModel.emailText
            )
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.required, .required(message: "We need your email bro xD"))
            .fieldStyle(.standardValidator, .email)
            
            SWTextField(
                title: "Your password",
                text: $viewModel.passwordText
            )
            .fieldStyle(.secureText, true)
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.required, .required(message: "Password is really required :("))
        }
        .padding(spacing)
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal)
    }
    
    private var middleSection: some View {
        VStack(spacing: spacing) {
            Text("Account")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
            
            SWPicker(
                title: "Your animal",
                data: viewModel.animals,
                selection: $viewModel.animalSelection
            )
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.pickerIcon, Image(systemName: "chevron.down.circle.fill"))
            
            HStack(alignment: .top, spacing: 16) {
                SWTextField(
                    title: "Your age",
                    text: $viewModel.ageText
                )
                .fieldStyle(.configuration, viewModel.configuration)
                .fieldStyle(.limitText, 2)
                .fieldStyle(.disabled, .constant(viewModel.erroredFields.contains(0)))
                
                SWDatePicker(
                    title: "Hour",
                    type: .hour(),
                    selection: $viewModel.hourDate
                )
                .fieldStyle(.configuration, viewModel.configuration)
                .fieldStyle(.disabledIcon, Image(systemName: "lock.circle.fill"))
                .fieldStyle(.disabled, .constant(viewModel.erroredFields.contains(1)))
            }
            
            SWDatePicker(
                title: "Your birthday",
                type: .date(format: "dd-MM-yyyy"),
                selection: $viewModel.birthdayDate
            )
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.extraView, AnyView(dateExtraView))
        }
        .padding(spacing)
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal)
    }
    
    private var bottomSection: some View {
        VStack(spacing: spacing) {
            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
            
            SWTextEditor(
                title: "Your notes",
                text: $viewModel.notesText
            )
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.required, .required(message: "We love your notes... Please enter at least 1 letter."))
            .fieldStyle(.limitText, 500)
            .fieldStyle(.height, 120)
            
            SWTextEditor(
                title: "Additional info",
                text: $viewModel.infoText
            )
            .fieldStyle(.configuration, viewModel.configuration)
            .fieldStyle(.limitText, 500)
            .fieldStyle(.height, 120)
            .fieldStyle(.disabled, .constant(viewModel.erroredFields.contains(7)))
        }
        .padding(spacing)
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal)
    }
    
    private var nameExtraView: some View {
        Rectangle()
            .fill(.indigo)
            .frame(width: 48)
            .overlay {
                Image(systemName: "person.fill")
                    .foregroundStyle(.white)
            }
    }
    
    private var dateExtraView: some View {
        Rectangle()
            .fill(.indigo)
            .frame(width: 48)
            .overlay {
                Image(systemName: "calendar")
                    .foregroundStyle(.white)
            }
    }
    
    private var info: some View {
        VStack {
            Text("Focused field ID: \(String(describing: viewModel.focusedFieldID))")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Errored fields: \(viewModel.erroredFields)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.footnote)
        .foregroundStyle(.gray)
        .padding()
    }
    
    private var changeStyleButton: some View {
        Menu {
            Button("Border") {
                viewModel.configuration = .border
            }
            Button("Fill") {
                viewModel.configuration = .fill
            }
            Button("Fill with shadow") {
                viewModel.configuration = .fillShadow
            }
            Button("Underline") {
                viewModel.configuration = .underline
            }
            Button("Underline with shadow") {
                viewModel.configuration = .underlineShadow
            }
            Button("Combo") {
                viewModel.configuration = .combo
            }
            Button("Combo with shadow") {
                viewModel.configuration = .comboShadow
            }
        } label: {
            Text("STYLE")
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundStyle(.white)
                .background(.indigo)
                .clipShape(Capsule())
        }
        .padding()
    }
    
    private var nextButton: some View {
        Button(action: {
            // action
        }, label: {
            Text("Next")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundStyle(.white)
                .background(.indigo)
                .clipShape(Capsule())
                .padding()
        })
        .opacity(viewModel.hasErrors ? 0.5 : 1.0)
        .disabled(viewModel.hasErrors)
    }
}

// MARK: - Preview

#Preview {
    FormView(
        viewModel: FormViewModel()
    )
}
