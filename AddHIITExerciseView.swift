//
//  AddHIITExerciseView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 21.12.23.
//

import Foundation

import SwiftUI

struct AddHIITExerciseView: View {
    @State var new_HIIT_Exercise: Exercise?
    @State var search_exercise: String = ""
    @State var session_input: String = ""
    @EnvironmentObject var data: Routine
    @EnvironmentObject var exerciseglossary: ExerciseGlossary
    @Environment (\.dismiss) var dismiss
        
    //function to match the input name of the exercise with the stored exercise
    func getExercise() -> Exercise? {
        return data.hiit_exercises.first(where: {$0.name.lowercased() == search_exercise.lowercased()})
    }
    
    
    
    var body: some View {
    VStack {
            Form{
                Section("Name:"){
                    TextField("Exercise name", text: $search_exercise)
                }
                Section("Session:"){
                    TextField("Indicate session", text: $session_input)
                }
            }
            VStack {
                if let exerciseSearchOutput = getExercise() {
                    HStack{
                        //
                        Image(exerciseSearchOutput.display)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding()
                        //
                        Text(exerciseSearchOutput.repetition)
                        //
                        Text(exerciseSearchOutput.name)
                        // Button to add the exercise to the session
                    }
                    Button("Add") {
                        if session_input == "1" {
                            data.HIITSession1.append(exerciseSearchOutput)
                            dismiss()}
                        else if session_input == "2" {
                            data.HIITSession2.append(exerciseSearchOutput)
                            dismiss()
                        }
                        else if session_input == "3" {
                            data.HIITSession3.append(exerciseSearchOutput)
                            dismiss()
                        }
                    }
                }
                
            }
            
        }.toolbar {
            ToolbarItem{
                NavigationLink{
                    ExerciseGlossaryView()
                } label: {
                    Image(systemName: "figure.run.square.stack.fill")
                }
            }
        }
    }
}

struct AddHIITExerciseView_previews: PreviewProvider {
    static var previews: some View {
        AddHIITExerciseView().environmentObject(Routine())
    }
}
