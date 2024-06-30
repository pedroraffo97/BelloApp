//
//  UserInformationView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct UserInformationView: View {
    @State var new_user = User(name: "", age: 0, sex: "", weight: 0, height: 0, amr: 0)
    @State var StringAge:String = ""
    @State var StringWeight:String = ""
    @State var StringHeight: String = ""
    @State var StringAmr: String = ""
    @EnvironmentObject var userinformation: UserInformation
    var body: some View {
        VStack{
            List {
                Section("Name"){
                    TextField("Enter your name", text: $new_user.name)}
                Section("Age") {
                    TextField("Enter your age", text: $StringAge)}
                Section("Sex") {
                    TextField("Enter your sex", text: $new_user.sex)}
                Section("Weight"){
                    TextField ("Enter your weight", text: $StringWeight)}
                Section("Height"){
                    TextField("Enter your height", text: $StringHeight)}
                Section("AMR") {
                    Text("AMR: Activity Level Metabolic Rate")
                    TextField("Enter your Activity Level Metabolic Rate", text: $StringAmr)}
            }.toolbar{
                ToolbarItem {
                    Button("Enter"){
                        if let DoubleAge = Double(StringAge),
                           let DoubleWeight = Double(StringWeight),
                           let DoubleHeight = Double (StringHeight),
                           let DoubleAmr = Double(StringAmr){
                            new_user.age = DoubleAge
                            new_user.weight = DoubleWeight
                            new_user.height = DoubleHeight
                            new_user.amr = DoubleAmr
                            userinformation.UserInformationDataBase.append(new_user)}
                    }
                }
            }
        }
    }
}
struct UserInformationView_previews: PreviewProvider {
    static var previews: some View {
        UserInformationView()
            .environmentObject(UserInformation())
    }
}
