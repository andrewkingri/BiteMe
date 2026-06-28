//
//  LoginView.swift
//  BiteMe
//
//  Created by Andrew King on 6/27/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var auth: AuthManager

    @State private var email = ""
    @State private var password = ""

    private var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.isEmpty
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 8) {
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Color.terracotta)
                Text("BiteMe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.coffee)
                Text("Sign in to start cooking")
                    .font(.subheadline)
                    .foregroundStyle(Color.coffee.opacity(0.6))
            }

            VStack(spacing: 12) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 24)

            Button {
                auth.logIn(email: email.trimmingCharacters(in: .whitespaces))
            } label: {
                Text("Log In")
                    .font(.headline)
                    .foregroundStyle(Color.cream)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(canSubmit ? Color.terracotta : Color.terracotta.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(!canSubmit)
            .padding(.horizontal, 24)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cream)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthManager())
    }
}
