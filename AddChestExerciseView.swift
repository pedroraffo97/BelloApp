//
//  AddChestExerciseView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct AddChestExerciseView: View {
    @State var new_Exercise = Exercise(name: "",bodypart: "", information: "", execution:"", repetition:"")
    @EnvironmentObject var data: Routine
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment:.leading){
                    Text("Name")
                        .foregroundStyle(.white)
                        .font(.headline)
                    TextField("", text: $new_Exercise.name)
                        .foregroundStyle(Color.white)
                        .textFieldStyle(.plain)
                        .frame(height: 30)
                        .cornerRadius(8)
                        .background(Color.black)
                }
                .padding()
                VStack(alignment:.leading){
                    Text("Repetition")
                        .foregroundStyle(.white)
                        .font(.headline)
                    TextField("", text: $new_Exercise.repetition)
                        .foregroundStyle(Color.white)
                        .textFieldStyle(.plain)
                        .frame(height: 30)
                        .cornerRadius(8)
                        .background(Color.black)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        data.chest_exercises.append(new_Exercise)
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
            .navigationTitle("Add Exercise")
            }
        }
    }

struct AddChestExerciseView_previews: PreviewProvider {
    static var previews: some View{
        AddChestExerciseView()
            .environmentObject(Routine())
    }
}

