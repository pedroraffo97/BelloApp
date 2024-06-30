//
//  AddLegExerciseView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct AddLegExerciseView: View {
    @State var new_Exercise = Exercise(name: "",bodypart: "", information: "", execution:"", repetition:"")
    @EnvironmentObject var data: Routine
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack(alignment:.leading) {
            Form {
                Section("Name"){
                    TextField("Name", text: $new_Exercise.name)
                }
                Section("Repetition"){
                    TextField("Repetitions", text: $new_Exercise.repetition)
                }
                
            }
        }.toolbar {
            ToolbarItem {
                Button("Add"){
                    data.leg_exercises.append(new_Exercise)
                    dismiss()
                    }
                }
            }
        
        }
    }

struct AddLegExerciseView_previews: PreviewProvider {
    static var previews: some View{
        AddLegExerciseView()
            .environmentObject(Routine())
    }
}
