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
    @State var skillExercises: [String] = []
    @State var stormExercises: [String] = []
    @State var strongRowExercises: [String] = []
    
    
    
    //MARK: New training instance where the user inputs go
    @State var new_Training = TrainingLog(name: "", day: "", kcal: "", exercises: "", group: [])
    
    
    //MARK: Date and Kcal as their real types
    @State var dateDay: Date = Date()
    @State var numberKcal: Float = 0
    
    
    //MARK: Function to add a new routine as Finished Training
    
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
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .frame(height: 50)
                            .background(Color.black)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)

                    }
                    .padding()
                    
                    
                    VStack(alignment:.leading){
                        HStack {
                            Text("Date")
                                .foregroundStyle(.white)
                                .font(.headline)
                            CustomDatePicker(date: $dateDay)
                                .frame(width: 200, height: 50)
                        }
                    }
                    .padding()
                    VStack(alignment:.leading){
                            Text("kCalories burned")
                                .foregroundStyle(.white)
                                .font(.headline)
                        HStack {
                            CustomNumberField(value: $numberKcal)
                                .frame(width: 200, height: 50)
                            Text("kCal")
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Add Routine")
            .toolbar {
                ToolbarItem {
                    Button {
                            //MARK: Convert kcal and date to string for saving
                            //from number KCal into String KCal
                            new_Training.kcal = String(format: "%.0f", numberKcal)
                            
                            //from Date() to String Date
                            let formatter = DateFormatter()
                            formatter.dateStyle = .short
                            new_Training.day = formatter.string(from: dateDay)
                            
                            if routineName == "Upper Front" {
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
                            }
                            else if routineName == "Upper Back" {
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
                            }
                            else if routineName == "Low" {
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
                            }
                            else if routineName == "Explosive" {
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
                            }
                            else if routineName == "You" {
                                for exercise in data.new_routine {
                                    if exercise.name == "" {
                                        let exerciseText = "Name: \(routineName), Repetition: \(exercise.repetition)"
                                        yourExercises.append(exerciseText)
                                    } else {
                                        let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                        yourExercises.append(exerciseText)
                                    }
                                }
                                new_Training.group.append(contentsOf:yourExercises)
                                routinetracker.FinishedTrainings.append(new_Training)
                            }
                            else if routineName == "skill" {
                                for exercise in data.skill_exercises {
                                    if exercise.name == "" {
                                        let exerciseText = "Name: \("skill Training"), Repetition: \(exercise.repetition)"
                                        skillExercises.append(exerciseText)
                                    } else {
                                        let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                        skillExercises.append(exerciseText)
                                    }
                                }
                                new_Training.group.append(contentsOf: skillExercises)
                                routinetracker.FinishedTrainings.append(new_Training)
                            }
                            else if routineName == "storm" {
                                for exercise in data.storm_exercises {
                                    if exercise.name == "" {
                                        let exerciseText = "Name: \("Storm Training"), Repetition: \(exercise.repetition)"
                                        stormExercises.append(exerciseText)
                                    } else {
                                        let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                                        stormExercises.append(exerciseText)
                                    }
                                }
                                new_Training.group.append(contentsOf: stormExercises)
                                routinetracker.FinishedTrainings.append(new_Training)
                            }
                            else if routineName == "strongRow" {
                                for exercise in data.strong_row_exercises {
                                    let name = exercise.name.isEmpty  ? "Strong Row" : exercise.name
                                    let exerciseText = "Name: \(name), Repetition: \(exercise.repetition)"
                                    strongRowExercises.append(exerciseText)
                                }
                                new_Training.group.append(contentsOf: strongRowExercises)
                                routinetracker.FinishedTrainings.append(new_Training)
                            }
                            dismiss()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .background(Color.black.opacity(0.9))
            }
        }
    }

//include 30 seconds of obligatory pause after the 3 min

struct AddRoutineView_previews: PreviewProvider {
    static var previews: some View{
        AddRoutineView()
    }
}
