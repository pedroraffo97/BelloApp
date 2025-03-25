//
//  AddRoutineView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct AddRoutineView: View {
    @EnvironmentObject var routinetracker: RoutineTracker
    @EnvironmentObject var data: Routine
    var routineName: String = ""
    @State var chestExercises: [String] = []
    @State var backExercises: [String] = []
    @State var legExercises: [String] = []
    @State var potenceExercises: [String] = []
    @State var yourExercises: [String] = []
    @State var new_Training = TrainingLog(name: "", day: "", kcal: "", exercises: "", group: [])
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    VStack(alignment:.leading){
                        Text("Training Name")
                            .foregroundStyle(.white)
                            .font(.headline)
                        TextField("", text: $new_Training.name)
                            .foregroundStyle(Color.white)
                            .textFieldStyle(.plain)
                            .frame(height: 30)
                            .cornerRadius(8)
                            .background(Color.black)
                    }
                    .padding()
                    VStack(alignment:.leading){
                        Text("Day")
                            .foregroundStyle(.white)
                            .font(.headline)
                        TextField("", text: $new_Training.day)
                            .foregroundStyle(Color.white)
                            .textFieldStyle(.plain)
                            .frame(height: 30)
                            .cornerRadius(8)
                            .background(Color.black)
                    }
                    .padding()
                    VStack(alignment:.leading){
                        Text("kcal")
                            .foregroundStyle(.white)
                            .font(.headline)
                        TextField("", text: $new_Training.kcal)
                            .foregroundStyle(Color.white)
                            .textFieldStyle(.plain)
                            .frame(height: 30)
                            .cornerRadius(8)
                            .background(Color.black)
                    }
                    .padding()
                    VStack(alignment:.leading){
                        Text("Additional Exercises")
                            .foregroundStyle(.white)
                            .font(.headline)
                        TextField("", text: $new_Training.exercises)
                            .foregroundStyle(Color.white)
                            .textFieldStyle(.plain)
                            .frame(height: 30)
                            .cornerRadius(8)
                            .background(Color.black)
                    }
                    .padding()
                }
            }
            .navigationTitle("Add Routine")
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button("Chest Routine"){
                            for exercise in data.chest_exercises {
                                if exercise.name == "" {
                                    let exerciseText = "Name: \(routineName), Repetition: \(exercise.repetition)"
                                    chestExercises.append(exerciseText)
                                } else {
                                    let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                    chestExercises.append(exerciseText) }
                            }
                            new_Training.group.append(contentsOf: chestExercises)
                            routinetracker.FinishedTrainings.append(new_Training)
                            dismiss()
                        }
                        
                        Button("Back Routine"){
                            for exercise in data.back_exercises {
                                if exercise.name == "" {
                                    let exerciseText = "Name: \(routineName), Repetition: \(exercise.repetition)"
                                    backExercises.append(exerciseText)
                                } else {
                                    let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                    backExercises.append(exerciseText)}
                            }
                            new_Training.group.append(contentsOf: backExercises)
                            routinetracker.FinishedTrainings.append(new_Training)
                            dismiss()

                        }
                        
                        Button("Leg Routine"){
                            for exercise in data.leg_exercises {
                                if exercise.name == "" {
                                    let exerciseText = "Name: \(routineName), Repetition: \(exercise.repetition)"
                                    legExercises.append(exerciseText)
                                } else {
                                    let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                    legExercises.append(exerciseText) }
                            }
                            new_Training.group.append(contentsOf: legExercises)
                            routinetracker.FinishedTrainings.append(new_Training)
                            dismiss()
                        }
                        
                        Button("Potence Routine"){
                            for exercise in data.potence_exercises {
                                if exercise.name == "" {
                                    let exerciseText = "Name: \(routineName), Repetition: \(exercise.repetition)"
                                    potenceExercises.append(exerciseText)
                                } else {
                                    let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                    potenceExercises.append(exerciseText) }
                            }
                            new_Training.group.append(contentsOf: potenceExercises)
                            routinetracker.FinishedTrainings.append(new_Training)
                            dismiss()
                        }
                        
                        Button("Your Routine"){
                            for exercise in data.new_routine {
                                if exercise.name == "" {
                                    let exerciseText = "Name: \(routineName), Repetition: \(exercise.repetition)"
                                    yourExercises.append(exerciseText)
                                } else {
                                    let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                    yourExercises.append(exerciseText)
                                }
                                new_Training.group.append(contentsOf:yourExercises)
                                routinetracker.FinishedTrainings.append(new_Training)
                                dismiss()
                            }
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                    }
                    /*Button {
                        routinetracker.FinishedTrainings.append(new_Training)
                        dismiss()
                        
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                    }*/
                }
            }
            .background(Color.black.opacity(0.9))
            }
        }
    }

struct AddRoutineView_previews: PreviewProvider {
    static var previews: some View{
        AddRoutineView()
    }
}
