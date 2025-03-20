//
//  AddUserInformation.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 16.07.24.
//

import Foundation

import SwiftUI


struct AddUserInformation: View {
    
    @EnvironmentObject var userinformation: UserInformation
    
    @State var newUser = User(name: "", age: 0, sex: "", weight: 0, height: 0, amr: 0, hip: 0.0, bai: 0.0, exerciseLevel: "")
    @State var StringAge: String = ""
    @State var StringWeight: String = ""
    @State var StringHeight: String = ""
    @State var StringAmr: String = ""
    @Environment (\.dismiss) var dismiss
    
    func addUserInformation(){
        if let DoubleAge = Double(StringAge),
           let DoubleWeight = Double(StringWeight),
           let DoubleHeight = Double (StringHeight){
            newUser.age = DoubleAge
            newUser.weight = DoubleWeight
            newUser.height = DoubleHeight
            userinformation.UserInformationDataBase.append(newUser)}
    }
    var body: some View {
        VStack {
            VStack {
                
                List {
                    //User Information Form
                    Section("Name"){
                        TextField("Enter your name", text: $newUser.name)}
                    Section("Age") {
                        TextField("Enter your age", text: $StringAge)}
                    Section("Sex") {
                        TextField("Enter your physiological sex (M/F)", text: $newUser.sex)}
                    Section("Weight"){
                        TextField ("Enter your weight", text: $StringWeight)}
                    Section("Height"){
                        TextField("Enter your height", text: $StringHeight)}
                    }
                    
                    // to return the function to see if it is authenticated
                    Button {
                        addUserInformation()
                        dismiss()
                    } label: {
                        Label("Sign Up",systemImage: "person.fill.badge.plus")
                    }
                    .buttonStyle(.bordered)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()

                    
                }
                .navigationTitle("Add your Information")
                
            }
    }
}
