//
//  ToolsView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 18.11.23.
//

import Foundation

import SwiftUI

struct ToolsView: View {
    var body: some View{
        List{
            NavigationLink{
                TrainerView()
                    .navigationTitle("Coach Wisdom")
            } label: {
                    Image("coach")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
                    Text("Coach Wisdom")
                    
                }
            NavigationLink{
                BodyFatView()
                    .navigationTitle("Body Fat Index")
            } label: {
                Image("body-fat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                Text("Body Fat Index")
            }
            NavigationLink {
                OneRepMaxView()
                    .navigationTitle("One Max Repetition")
            } label: {
                Image("repetition")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                Text("1 Max Repetition")
            }
            NavigationLink{
                CaloricReqView()
                    .navigationTitle("Caloric Requirement")
            } label:{
                Image("calories")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                Text("Caloric Requirement")
            }
            NavigationLink{
                TrainingRecomView()
                    .navigationTitle("BMI Training Tips")
            } label:{
                Image("bmi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                Text("BMI Training Tips")
            }

            }
        }
    }

struct ToolsView_Preview: PreviewProvider {
        static var previews: some View {
            ToolsView()
        }
    }
