//
//  BodyFatView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.11.23.
//

import Foundation

import SwiftUI

struct BodyFatView: View {
    @EnvironmentObject var userinformation: UserInformation
    @State var StringHip: String = ""
    @State var StringHeight: String = ""
    @State var StringName: String = ""
    @State var FatPercentage : Double = 0.0
    
    func calculateBAI() -> Double?{
        guard
            let hip = Double(StringHip),
            let height = Double(StringHeight),
            height != 0 else {
            //Handle invalid input or divided by zero
            return nil
        }
        let bodyPercentage: Double = hip / height * 100
        FatPercentage = bodyPercentage
        
        return bodyPercentage
    }
    var body: some View {
        ScrollView{
            VStack {
                HStack{
                    Image("calculateBAI")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    Image("CalculateBAI2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    
                }
                Text("""
                 The body fat percentage of a person or animal is the total weight of fat divided by total weight; body fat includes essential body fat and storage body fat. Essential body fat is necessary to maintain life and reproductive functions. The percentage of essential fat is 3-5% in men and 10-16% in women.
                 """)
                .padding()
                HStack{
                    Spacer(minLength: 20)
                    Text("Name:")
                    TextField("Enter your name", text: $StringName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer(minLength: 20)
                }
                .padding()
                HStack{
                    Spacer(minLength: 20)
                    Text("Hip:")
                    TextField("Enter your hip measure in cm",text: $StringHip)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer(minLength: 20)
                }
                .padding()
                HStack{
                    Spacer(minLength: 20)
                    Text("Height:")
                    TextField("Enter your height measure in cm", text: $StringHeight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer(minLength: 20)
                }
                .padding()
                Button("Calculate Fat%"){
                    if var user = userinformation.UserInformationDataBase.first(where:{$0.name == StringName}) {
                        if let calculateBAI = calculateBAI(){
                            user.bai = calculateBAI
                            userinformation.save_UserInformation()
                            FatPercentage = user.bai
                        }
                    }
                }
            }
            .padding()
            HStack{
                Text("Result:")
                Text(String(FatPercentage))
                Text("%")
            }
            
        }
    }
}



struct BodyFatView_previews: PreviewProvider {
    static var previews: some View{
        BodyFatView(StringHip: "", StringHeight: "", StringName: "", FatPercentage: 0).environmentObject(UserInformation())

    }
}
