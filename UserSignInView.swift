//
//  UserSignInView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 05.04.24.
//

import Foundation

import SwiftUI


struct UserSignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signInError: Error?
    
    func signIn() {
        AuthenticationManager.shared.SignIn(email: email, password: password)
    }
    
    var body: some View {
        VStack {
            VStack{
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button {
                    signIn()
                } label: {
                    Label("Sign In", systemImage: "person.crop.circle.fill.badge.checkmark")
                }
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
                VStack{
                    Text("Not yet in Bello")
                        .padding()
                    NavigationLink {
                        UserSignUpView()
                    } label: {
                        Label("Create a new account", systemImage: "person.fill.badge.plus")
                    }
                }
                
                if let error = signInError {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Sign In")
        }
    }
}
