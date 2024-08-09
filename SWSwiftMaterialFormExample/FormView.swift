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
            erroredText
            form
            nextButton
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .onTapGesture { viewModel.unfocusFields = true }
    }
    
    // MARK: - Subviews
    
    private var erroredText: some View {
        Text("Errored fields: \(viewModel.erroredFields)")
            .font(.caption)
            .foregroundStyle(.gray)
            .padding()
    }
    
    private var form: some View {
        SWContainerView(spacing: spacing, errors: $viewModel.hasErrors) {
            topSection
            middleSection
            bottomSection
        }
        .containerStyle(key: .startWithFocusedFieldAfter, 0)
        .containerStyle(key: .unfocusFields, $viewModel.unfocusFields)
        .containerStyle(key: .erroredFields, $viewModel.erroredFields)
        .containerStyle(key: .backgroundColor, viewModel.backgroundColor)
        .containerStyle(key: .animation, .bouncy)
        .containerStyle(key: .toolbarFont, .headline)
        .containerStyle(key: .toolbarTintColor, .pink)
    }
    
    private var topSection: some View {
        VStack(spacing: spacing) {
            Text("Top")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
            
            SWTextFieldView(title: "Your name", text: $viewModel.nameText)
                .fieldStyle(key: .configuration, .underlineShadow)
                .fieldStyle(key: .required, .required(message: "Tell us your name please :)"))
                .fieldStyle(key: .extraView, AnyView(nameExtraView))
            
            SWTextFieldView(title: "Your email", text: $viewModel.emailText)
                .fieldStyle(key: .configuration, .underlineShadow)
                .fieldStyle(key: .required, .required(message: "We need your email bro xD"))
                .fieldStyle(key: .standardValidator, .email)
            
            SWTextFieldView(title: "Your password", text: $viewModel.passwordText)
                .fieldStyle(key: .secureText, true)
                .fieldStyle(key: .configuration, .underlineShadow)
                .fieldStyle(key: .required, .required(message: "Password is really required :("))
        }
        .padding(spacing)
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal)
    }
    
    private var middleSection: some View {
        VStack(spacing: spacing) {
            Text("Middle")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
        }
        .padding(spacing)
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal)
    }
    
    private var bottomSection: some View {
        VStack(spacing: spacing) {
            Text("Bottom")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
        }
        .padding(spacing)
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal)
    }
    
    private var nameExtraView: some View {
        Rectangle()
            .fill(.pink)
            .frame(width: 48)
            .overlay {
                Image(systemName: "star")
                    .foregroundStyle(.white)
            }
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
                .background(.pink)
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
