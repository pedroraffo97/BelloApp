//
//  CalculateAMR.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 04.07.24.
//

import Foundation

import SwiftUI

struct ButtonGroup: View {
    let items: [String]
    @Binding var selectedOption: String
    var body: some View {
        ForEach(items, id: \.self){ item in
            Button {
                selectedOption = item
            } label: {
                HStack{
                    if selectedOption == item {
                        Image(systemName: "largecircle.fill.circle")
                            .foregroundColor(.black)
                    }
                    else {
                        Image(systemName: "circle")
                    }
                    Text(item)
                }
                .padding()
                .foregroundColor(.black)
            }
        }
    }
}

struct CalculateAMR: View {
    @EnvironmentObject var userinformation:UserInformation
    @State  var selectedOption: String = ""
    @State var calculatedAMR: Double = 0
    
    
    func AMRtoUserInformation(){
        if let firstUser = userinformation.UserInformationDataBase.first {
            if let index = userinformation.UserInformationDataBase.firstIndex(where: {$0.id == firstUser.id}) {
                //will set selectedOption as the exerciseLevel of the user
                userinformation.UserInformationDataBase[index].exerciseLevel = selectedOption
                //call the function to calculate the amr with the user id
                userinformation.CalculateAMRwithUser(userID: firstUser.id)
                //set the user amr as the calculatedAMR to be displayed in the view
                calculatedAMR = userinformation.UserInformationDataBase[index].amr
                }
            }
        }
    
    var body: some View {
        VStack {
            Text("Please select the amount of times you trained per week")
                .padding()
            ButtonGroup(items: ["Light 1x week", "Moderate 3x week", "Heavy 5x week", "Extra heavy 6-7x week"], selectedOption: $selectedOption)
            Button {
                AMRtoUserInformation()
            } label: {
                Text("Calculate AMR")
            }
            .buttonStyle(.bordered)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            HStack{
                Text("Your AMR:")
                Text("\(Int(calculatedAMR))")
            }
            
        }
        
    }
}
