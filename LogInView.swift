//
//  LogInView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct LogInView: View {
    @State var username = ""
    @State var password = ""
    var body: some View {
        
        Text("Log In")
            .font(.title)
        VStack{
            HStack{
                TextField("Username",text: $username)
                .multilineTextAlignment(.center)
                TextField("Password", text: $password)
                .multilineTextAlignment(.center)
            }
        }
        .padding()
        VStack{
            Text("Log In Information")
                .font(.headline)
                .bold()
                .padding()
            Text("Username: \(username)")
                .padding()
            Text("Password:  \(password)")
                .padding()
            NavigationStack{
                NavigationLink("Enter"){
                    MenuView().navigationTitle("Menu")
                } }
            }
        }
        
    }

struct Log_In_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
