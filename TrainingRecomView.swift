//
//  TrainingRecomView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 24.11.23.
//

import Foundation

import SwiftUI


struct TrainingRecomView: View {
    @EnvironmentObject var userinformation : UserInformation
    @State var StringName: String = ""
    @State var Recommendation: String = ""
    
    //function to match the inputted name with the stored userinformation data.
    func getUser() -> User? {
        return userinformation.UserInformationDataBase.first(where:{ $0.name.lowercased() == StringName.lowercased()})
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                //input name
                HStack{
                    Text("Name:")
                    TextField("Input your name" ,text: $StringName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                Text("Tailored recommendations depending on your BMI level.")
                    .padding()
                Text("""
                Body Mass Index (BMI) is a numerical value of a person's weight in relation to their height. It is a widely used screening tool to categorize individuals into different weight status categories.

                """)
                
                .padding()
                
                Image("bodytypes")
                    .resizable()
                    .scaledToFit()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                //output name
                HStack{
                    Text("Name:")
                    if let user = getUser() {
                        Text(String(user.name))
                    }
                }
                .font(.headline)
                .padding(10)
                
                //output weight
                HStack{
                    Text("Weight:")
                    if let user = getUser() {
                        Text(String(user.weight))
                    }
                }
                .font(.headline)
                .padding(10)
                
                //output bmi
                HStack{
                    Text("BMI:")
                    if let user = getUser(){
                        Text(String(user.bmi))
                    }
                }
                .font(.headline)
                .padding(10)
                
                //output weight status
                HStack{
                    Text("Weight Status:")
                        .font(.headline)
                    
                    VStack{
                        if let user = getUser(){
                            if user.bmi <= 18.5 {
                                Text("Underweight")
                            }
                            else if user.bmi > 19 && user.bmi <= 24.9 {
                                Text("Normal weight")
                            }
                            else if user.bmi > 25 && user.bmi < 29.99 {
                                Text("Overweight")
                            }
                            else if user.bmi >= 30 {
                                Text("Obesity")
                            }
                        }
                    }
                }
                .padding()
                
                
                
                //output training recommendation depending on your bmi level
                VStack{
                    Text("Recommendation")
                        .font(.title3)
                        .bold()
                        .padding()
                    VStack{
                        if let user = getUser(){
                            if user.bmi <= 18.5 {
                                Text(underweight.description)
                            }
                            else if user.bmi > 19 && user.bmi <= 24.9 {
                                Text(normalweight.description)
                            }
                            else if user.bmi > 25 && user.bmi < 29.99 {
                                Text(overweight.description)
                            }
                            else if user.bmi >= 30 {
                                Text(obesity.description)
                            }
                        }
                    }
                }
                .padding(10)
                
                Text("""
                *While BMI provides a useful general
                guideline, it doesn't directly measure body
                fat and may not accurately represent the
                health of individuals with high muscle mass.
                It's always a good idea to consider other
                factors like waist circumference, body fat
                percentage, and overall health assessments
                for a more comprehensive understanding of
                one's health.
                """)
                .font(.footnote)
                .padding()
            }
        }
    }
}

struct TrainingRecomView_Preview: PreviewProvider {
    static var previews: some View {
        TrainingRecomView()
            .environmentObject(UserInformation())
            
    }
}
