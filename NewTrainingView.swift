//
//  NewTrainingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct NewTrainingView: View {
    var body: some View {
        VStack {
            Text("Please select one Training").font(.headline)
            NavigationStack {
                List {
                    NavigationLink{
                        ChestTrainingView().navigationTitle("Chest Training")
                    } label: {
                        Image("chest")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Chest")
                    }
                    NavigationLink{
                        BackTrainingView().navigationTitle("Back Training")
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Back")
                    }
                    NavigationLink{
                        LegTrainingView().navigationTitle("Leg Training")
                    } label: {
                        Image("leg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Leg")
                    }
                    NavigationLink{
                        PotenceTrainingView().navigationTitle("Potence Training")
                    } label: {
                        Image("boost")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Boost")
                    }
                    NavigationLink{
                        NewRoutineView()
                        .navigationTitle("Your Training")}
                        label: {
                                Image(systemName:"dumbbell")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                            Text("You")
                        }
                    }
                }
            }
        }
    }

struct NewTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrainingView()
    }
}
