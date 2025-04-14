//
//  StrongRowView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 14.04.25.
//
import Foundation
import SwiftUI


struct StrongRowView: View {
    
    var WarmUpExercises: [Exercise] = [legSwings, highKnees, aSkips, jumpingJacks]
    var strongExerciseswithoutRow: [Exercise] = [kettlebellThruster, kettlebellOverheadLunges, burpees]
    var strongExercises: [Exercise] = [kettlebellThruster, kettlebellOverheadLunges, burpees, rowing]
    var Row: [Exercise] = [rowing]
    var rest: [Exercise] = [resting]
    var cooldown: [Exercise] = [catCowStretch, hipFlexorStretch, seatedForwardStretch, quadricepsStretch, calfStretch]

    @State var finishRoutine: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                //MARK: Warm Up Rowing
                VStack (alignment: .center, spacing: 16) {
                    Text("1st Warm Up Rowing")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    HStack {
                        Text("2min")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                        Menu {
                            VStack{
                                Text("Press the button to start the countdown.")
                            }
                            
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.white)
                        }
                    }
                    //Exercises
                    TrainingSectionList(exercises: Row)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Easy Rowing", exercises: Row, time: 120, resttime: 0, tapstoChangeColor: 1)
                        .padding()
                }
                .padding()
                //MARK: Warm Up
                VStack (alignment: .center, spacing: 16) {
                    Text("2nd Warm Up")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    HStack {
                        Text("2min")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                        Menu {
                            VStack{
                                Text("Press the button to start the countdown.")
                            }
                            
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.white)
                        }
                    }
                    //Exercises
                    TrainingSectionList(exercises: WarmUpExercises)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Let's Warm Up 🔥", exercises: WarmUpExercises, time: 120, resttime: 0, tapstoChangeColor: 1)
                        .padding()
                }
                .padding()
                //MARK: Training
                VStack (alignment: .center, spacing: 16) {
                    Text("Strong Row Training")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    HStack {
                        Text("25 min EMOM")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                        Menu {
                            VStack{
                                Text("Press the button to start the countdown.")
                            }
                            
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.white)
                        }
                    }
                    HStack(alignment: .center){
                        Text("2x 4x 6x 8x 10x.... 20x every exercise each side")
                            .bold()
                        .foregroundStyle(.white)}
                    //Exercises
                    TrainingSectionList(exercises: strongExerciseswithoutRow)
                    
                    HStack {
                        Text("200M Rowing")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    //Exercises
                    TrainingSectionList(exercises: Row)
                    
                    //Button to start section
                    TrainingSectionTogetherView(buttonTitle: "Start 🚀", exercises: strongExercises, repetition: "EMOM", time: 1500, resttime: 0, tapstoChangeColor: 1)
                    TrainingSectionView(buttonTitle: "Rest 🍃", exercises: rest, time: 120, resttime: 0, tapstoChangeColor: 1)
                }
                .padding()
                //MARK: Regata
                VStack (alignment: .center, spacing: 16) {
                    Text("Regata")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    HStack {
                        Text("2 min Race")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                        Menu {
                            VStack{
                                Text("Press the button to start the countdown.")
                            }
                            
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.white)
                        }
                    }
                    //Exercises
                    TrainingSectionList(exercises: Row)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Start 🏁", exercises: Row, repetition: "All in", time: 120, resttime: 0, tapstoChangeColor: 1)
                    TrainingSectionView(buttonTitle: "Rest 🍃", exercises: rest, time: 120, resttime: 0, tapstoChangeColor: 1)
                }
                .padding()
                
                
                //MARK: Cool Down
                VStack (alignment: .center, spacing: 16) {
                    Text("Cool Down")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    HStack {
                        Text("2min")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                        Menu {
                            VStack{
                                Text("Press the button below to start the countdown.")
                            }
                            
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.white)
                        }
                    }
                    //Exercises
                    TrainingSectionList(exercises: cooldown)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Cool Down 🍃", exercises: cooldown, time: 180, resttime: 0, tapstoChangeColor: 1)
                        .padding()
                }
                .padding()
                
                //MARK: Press button to finish the Routine
                Button {
                    finishRoutine = true
                } label: {
                    Label("Finish Routine", systemImage: "checkmark.circle")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                }
                .font(.headline)
                .buttonStyle(.bordered)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .navigationTitle("Strong Row")
            .background(Color.black.opacity(0.9))
            .sheet(isPresented: $finishRoutine) {
                AddRoutineView(routineName: "strongRow")
            }
        }
    }
}
