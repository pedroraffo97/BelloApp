//
//  UserSignUpView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 05.04.24.
//

import Foundation

import SwiftUI


struct UserSignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var signUpError: Error?
    @Environment (\.dismiss) var dismiss
    
    func signUp(){
        AuthenticationManager.shared.signUp(email: email, password: password)
    }
    
    
    var body: some View {
        VStack {
            VStack {
                //Sign Up Form
                TextField("create a new Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("create a new Password",text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // to return the function to see if it is authenticated
                Button {
                    signUp()
                    dismiss()
                } label: {
                    Label("Sign Up",systemImage: "person.fill.badge.plus")
                }
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
                
                if let error = signUpError {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
                
            }
            .navigationTitle("Sign Up")
            
        }
        .onAppear{
            AuthenticationManager().isAuthenticated = false
        }
    }
}
