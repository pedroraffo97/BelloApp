//
//  UserProfileView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 22.10.23.
//

import Foundation

import SwiftUI



struct UserProfileView: View {
    @EnvironmentObject var userinformation: UserInformation
    @State var bodyMassPercentage: Double = 0.0
    
    var body: some View {
        VStack{
            Image("gymbackground")
                .resizable()
                .scaledToFill()
                .frame(height: 30)
            if userinformation.UserInformationDataBase == [] {
                NavigationLink {
                    AddUserInformation()
                } label: {
                    Label("Add Information", systemImage: "plus")
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                List{
                    ForEach(userinformation.UserInformationDataBase) { information in
                        UserInformationDisplay(name: information.name, age: information.age, sex: information.sex, weight: information.weight, height: information.height, amr: information.amr, hip: information.hip, bai: information.bai, bmi: information.bmi, MaleBMR: information.MaleBMR, FemaleBMR: information.FemaleBMR, TDEE: information.TDEE)
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            let user = userinformation.UserInformationDataBase[index]
                            userinformation.deleteUserInformationfromFirestore(user: user)
                        }
                        userinformation.UserInformationDataBase.remove(atOffsets: indexSet)
                    })
                }
            }
            VStack{
                HStack {
                    VStack{
                        NavigationLink {
                            UserInformationView()
                        } label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                        .font(.headline)
                        .buttonStyle(.bordered)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(45)
                    UserLogOutView()
                }
            }
            .padding()
            .frame(height: 100.0)
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(UserInformation())
    }
}
