//
//  AddExerciseView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 28.03.25.
//

import Foundation

import SwiftUI

struct AddExerciseView: View {
    @Binding var data: [Exercise]
    @State var new_Exercise = Exercise(name: "",bodypart: "", information: "", execution:"", repetition:"")
    @Environment(\.dismiss) var dismiss
    @State var showexercisePortfolio: Bool = false
    var body: some View {
        NavigationView {
            ScrollView{
                //MARK: Add an exercise manually
                VStack(alignment:.leading){
                    Text("Name")
                        .foregroundStyle(.white)
                        .font(.headline)
                    TextField("", text: $new_Exercise.name)
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
                    Text("Repetition")
                        .foregroundStyle(.white)
                        .font(.headline)
                    TextField("", text: $new_Exercise.repetition)
                        .foregroundStyle(Color.white)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .frame(height: 50)
                        .background(Color.black)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)

                }
                .padding()
                /*
                //MARK: Access to the Exercise Portfolio
                Button {
                    showexercisePortfolio = true
                } label: {
                    Label("Exercise Glossary", systemImage: "book")
                        .font(.headline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()*/
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        data.append(new_Exercise)
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
            /*.sheet(isPresented: $showexercisePortfolio) {
                ExerciseListView(data: $data)
                }*/
            }
        }
    }
