//
//  UserInformationView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct UserInformationView: View {
    @EnvironmentObject var userinformation: UserInformation
    @State var StringAge: String = ""
    @State var StringWeight: String = ""
    @State var StringHeight: String = ""
    
    func UpdateUserInformation() {
        if let firstUser = userinformation.UserInformationDataBase.first {
            if let index = userinformation.UserInformationDataBase.firstIndex(where: {$0.id == firstUser.id}) {
                userinformation.UserInformationDataBase[index].age = Double(StringAge) ?? 0
                userinformation.UserInformationDataBase[index].weight = Double(StringWeight) ?? 0
                userinformation.UserInformationDataBase[index].height = Double(StringHeight) ?? 0
                userinformation.CalculateAMRwithUser(userID: firstUser.id)
            }
        }
    }
    
    var body: some View {
        VStack {
                List {
                    ForEach( userinformation.UserInformationDataBase.indices, id: \.self){
                        index in
                        let information = userinformation.UserInformationDataBase[index]
                        Section("Name"){
                            TextField(information.name, text: $userinformation.UserInformationDataBase[index].name)}
                        Section("Age") {
                            TextField("\(String(information.age))", text: $StringAge)}
                        Section("Sex") {
                            TextField(information.sex, text: $userinformation.UserInformationDataBase[index].sex)}
                        Section("Weight"){
                            TextField ("\(String(information.weight))", text: $StringWeight)}
                        Section("Height"){
                            TextField("\(String(information.height))", text: $StringHeight)}
                    }
                }
                .toolbar{
                    ToolbarItem {
                        Button("Update"){
                            UpdateUserInformation()
                            
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
