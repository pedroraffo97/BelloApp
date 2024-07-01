//
//  AuthenticationManager.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 05.04.24.
//

import Foundation

import Firebase

import FirebaseAuth

class AuthenticationManager: ObservableObject {
    //singleton design pattern: defining a static shared property, only one instance of AuthenticationManager() in the App.
    static let shared = AuthenticationManager()
    
    //Declares a published property to track the authentication status of the user in the app.
    @Published var isAuthenticated = false
    
    //Declares a published property that will change depending on the SignIn of the user.
    @Published var userID: String?
    
    //Local function to update the userID with the currentUser, once the currentUser is set.
    private func updateUserID() {
        if let currentUser = Auth.auth().currentUser {
            userID = currentUser.uid
        }
        else {
            userID = nil
        }
    }
    //Call the updateUserID when AuthenticationManager is initialized
    init() {
        updateUserID()
    }
    
    //Method to sign in an alraedy created account in Firebase
    func SignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] authResult, error in
            guard error == nil,
            let _ = authResult else {
                print("Error signing in: \(error?.localizedDescription ?? "")")
                self?.isAuthenticated = false
                return
                }
            //Update isAuthenticated directly upon succesful signIn
            print("Succesfully SignIn")
            self?.isAuthenticated = true
        }
    }
    
    //Method to check if there is an authenticated current User.
    func isUserAuthenticated() -> Bool {
        //Check if there is a currently authenticated user
        if let _ = Auth.auth().currentUser {
            //User is authenticated
            print("the current user is \(userID ?? "no user")")
            return true
        }
        else {
            print("no user is authenticated")
            return false
        }
    }
    
    //Method to create a new user in Firebase
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] authResult, error in
            guard error == nil,
            let _ = authResult else {
                self?.isAuthenticated = false
                return
            }
            print("Succesful Sign Up")
            self?.isAuthenticated = true
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            print("Succesfully LogOut")
        }
        catch {
            print("Error signing out:\(error.localizedDescription)")
        }
    }

}
