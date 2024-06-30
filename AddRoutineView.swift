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
    @State var chestExercises: [String] = []
    @State var backExercises: [String] = []
    @State var legExercises: [String] = []
    @State var potenceExercises: [String] = []
    @State var yourExercises: [String] = []
    @State var new_Training = TrainingLog(name: "", day: "", kcal: "", exercises: "", group: [])
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            List{
                Section("training name") {
                    TextField("Name", text: $new_Training.name)
                }
                Section("day") {
                    TextField("Day", text: $new_Training.day)
                }
                Section("kcal") {
                    TextField("Kcal", text: $new_Training.kcal)
                }
                Section("routine") {
                    Button("Add Chest Routine"){
                        for exercise in data.chest_exercises {
                            let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                            chestExercises.append(exerciseText)
                        }
                        new_Training.group.append(contentsOf: chestExercises)
                    }
                    Button("Add Back Routine"){
                        for exercise in data.back_exercises {
                            let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                            backExercises.append(exerciseText)
                        }
                        new_Training.group.append(contentsOf: backExercises)
                    }
                    Button("Add Leg Routine"){
                        for exercise in data.leg_exercises {
                            let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                            legExercises.append(exerciseText)
                        }
                        new_Training.group.append(contentsOf: legExercises)
                    }
                    Button("Add Potence Routine"){
                        for exercise in data.potence_exercises {
                            let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                            potenceExercises.append(exerciseText)
                        }
                        new_Training.group.append(contentsOf: potenceExercises)
                    }
                    Button("Add Your Routine"){
                        for exercise in data.new_routine {
                            let exerciseText = "Name: \(exercise.name), Repetition: \(exercise.repetition)"
                            yourExercises.append(exerciseText)}
                        new_Training.group.append(contentsOf:yourExercises)}
                }
                Section("Extra Exercises"){
                    TextField("Exercises", text: $new_Training.exercises)
                }
            }.toolbar{
                ToolbarItem {
                    Button("Add Training") {
                        routinetracker.FinishedTrainings.append(new_Training)
                        dismiss()
                        
                        }
                    }
                }
            }
    }
    }

struct AddRoutineView_previews: PreviewProvider {
    static var previews: some View{
        AddRoutineView()
    }
}
