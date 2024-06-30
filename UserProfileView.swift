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
                List{
                    ForEach(userinformation.UserInformationDataBase) { information in
                        VStack {
                            HStack{
                                Text("\(information.name)")
                                    .font(.title)
                                    .padding()
                                Image("profile-user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                            }
                            HStack{
                                VStack{
                                    Text("User Age")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(String(information.age))")
                                }
                                .padding()
                                VStack{
                                    Text("User Sex")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(information.sex)")
                                }
                            }
                            HStack{
                                VStack{
                                    Text("User Weight")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(String(information.weight))")
                                }
                                .padding()
                                
                                VStack{
                                    Text("User Height")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(String(information.height))")
                                }
                                .padding()
                            }
                            HStack{
                                Spacer()
                                VStack {
                                    Text("User BMI")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(String(information.bmi))")
                                }
                                .padding()
                                VStack {
                                    Text("User BMR")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(String(information.MaleBMR))")
                                }
                                .padding()
                                VStack {
                                    Text("User TDEE")
                                        .font(.headline)
                                        .padding(0.5)
                                    Text("\(String(information.TDEE))")
                                }
                                Spacer()
                                }
                            .padding()
                            }
                        }
                    }
                }
            }
        }

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(UserInformation())
    }
}
