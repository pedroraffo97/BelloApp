//
//  UserLogOutView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 05.04.24.
//

import Foundation

import SwiftUI

import Firebase

import FirebaseAuth

struct UserLogOutView: View {
    @Environment (\.dismiss) var dismiss
    
    func logOut(){
        AuthenticationManager.shared.signOut()
        AuthenticationManager().isAuthenticated = false
        let userID = Auth.auth().currentUser?.uid
        print("user succesfully signed out")
        //check if there was a user id stranded after signing out
        print("current user id is \(userID ?? "No User")")
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button{
                        logOut()
                        dismiss()
                    } label: {
                        Label("Log out", systemImage: "person.badge.key.fill")
                    }
                    .font(.headline)
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
