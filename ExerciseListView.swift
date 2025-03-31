//
//  ExerciseListView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 31.03.25.
//

import Foundation

import SwiftUI


struct ExerciseListView: View {
    @EnvironmentObject var exerciseglossary: ExerciseGlossary
    @State private var searchText: String = ""
    @State var selectRoutine: String = ""
    @State private var selectedExercise: Exercise? = nil
    @Binding var data: [Exercise]
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exerciseglossary.ExerciseGuide
        }
        else {
            return exerciseglossary.ExerciseGuide.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                exercise.bodypart.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                exercise.display.localizedCaseInsensitiveContains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        VStack{
            NavigationView{
                ScrollView(.vertical){
                    let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(filteredExercises, id: \.self){exercise in
                            Button {
                                selectedExercise = exercise
                            } label: {
                                GeometryReader {
                                    geometry in
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black.opacity(0.8))
                                        .shadow(radius: 1.5)
                                        .frame(width: geometry.size.width - 10, height: 180)
                                        .overlay(
                                            VStack {
                                                Image(exercise.display)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                                VStack{
                                                    Text(exercise.name)
                                                    Text(exercise.bodypart)
                                                        .font(.footnote)
                                                    }
                                                .foregroundStyle(Color.white)
                                                }
                                                .padding()
                                            )
                                        }
                                    }
                                    .frame(height: 180)
                            }
                        }
                        .padding(15)
                    }
                    .navigationTitle("Exercise Glossary")
                    .searchable(text: $searchText)
                    .onAppear {
                        let searchTextField = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
                            searchTextField.textColor = .white  // Ensures entered text is white
                            searchTextField.attributedPlaceholder = NSAttributedString(
                                string: "Search",
                                attributes: [.foregroundColor: UIColor.lightGray] // Makes placeholder more visible
                            )
                        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
                    }
                    .background(Color.black.opacity(0.9))
                    .sheet(item: $selectedExercise){
                        exerciseType in
                        AddExercisefromListView(exercise: exerciseType, data: $data)
                    }
                }
            }
        }
    }
