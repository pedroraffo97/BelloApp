//
//  SkillHIITView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 03.04.25.
//
import Foundation
import SwiftUI


struct SkillHIITView: View {
    
    var WarmUpExercises: [Exercise] = [jumpingJacks, armCircles, legSwings, highKnees, mountainClimbers]
    var firstRound: [Exercise] = [kettlebellCleanAndPress, kettlebellThruster, kettlebellOverheadLunges]
    var secondRound: [Exercise] = [americanSwing, russianTwist, burpees]
    var thirdRound: [Exercise] = [rowing, ergobike, running]
    var cooldown: [Exercise] = [catCowStretch, hipFlexorStretch, seatedForwardStretch, quadricepsStretch, calfStretch]

    @State var finishRoutine: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 16) {
                    Text("Warm Up")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    //Exercises
                    HIITSectionList(exercises: WarmUpExercises)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Let's Warm Up 🔥", exercises: WarmUpExercises, time: 120)
                        .padding()
                }
                .padding()
                VStack (alignment: .leading, spacing: 16) {
                    Text("1 Round")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    //Exercises
                    HIITSectionList(exercises: firstRound)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Start 1 Round 🛎️", exercises: firstRound, time: 180)
                        .padding()
                }
                .padding()
                VStack (alignment: .leading, spacing: 16) {
                    Text("2 Round")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    //Exercises
                    HIITSectionList(exercises: secondRound)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Start 2 Round 🛎️", exercises: secondRound, time: 180)
                        .padding()
                }
                .padding()
                VStack (alignment: .leading, spacing: 16) {
                    Text("3 Round")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    //Exercises
                    HIITSectionList(exercises: thirdRound)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Start 3 Round 🛎️", exercises: thirdRound, time: 180)
                        .padding()
                }
                .padding()
                
                //MARK: Cool down section
                VStack (alignment: .leading, spacing: 16) {
                    Text("Cool Down")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    //Exercises
                    HIITSectionList(exercises: cooldown)
                    //Button to start section
                    TrainingSectionView(buttonTitle: "Cool Down 🍃", exercises: cooldown, time: 180)
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
            .navigationTitle("Skill")
            .background(Color.black.opacity(0.9))
            .sheet(isPresented: $finishRoutine) {
                AddRoutineView(routineName: "skill")
            }
        }
    }
}

struct HIITSectionList: View {
    var exercises: [Exercise]

    var body: some View {
        VStack(spacing: 0) {
            // Tarjeta con fondo negro
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .overlay(
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(exercises, id: \.name) { training in
                                HStack(alignment: .center, spacing: 12) {
                                    Image(training.display)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text(training.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            }
                        }
                        .padding()
                    }
                )
                .frame(width: 350, height: 220) // Fijo o ajustable según tu diseño
        }
    }
}
