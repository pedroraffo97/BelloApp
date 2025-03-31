//
//  TrainingRouteView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 24.03.25.
//

import Foundation

import SwiftUI

struct TrainingRouteView: View {
    
    @Binding var dataVariable: [Exercise]
    var routineName: String
    
    @EnvironmentObject var routinetracker: RoutineTracker
    
    @State var showExerciseDescription: Exercise? = nil
    @State var showAddExercise: Bool = false
    @State var showExerciseList: Bool = false
    @State var finishRoutine: Bool = false
    @State private var showDeleteTaskMenu: Bool = false
    @State private var selectedExerciseID: UUID? = nil
    
    func deleteExercise(_ exerciseID: UUID) {
        if let index = dataVariable.firstIndex(where: {$0.id == exerciseID}) {
            dataVariable.remove(at: index)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 1)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(dataVariable, id: \.self) {
                        exercise in
                            GeometryReader {
                                geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                                    .shadow(radius: 1.5)
                                    .frame(height: 100)
                                    .overlay(
                                        HStack {
                                            Image(exercise.display)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .padding()
                                            Spacer()
                                            VStack (alignment: .trailing) {
                                                Text(exercise.repetition)
                                                    .font(.title)
                                                    .bold()
                                                Text(exercise.name)
                                                    .font(.headline)
                                                }
                                            }
                                            .padding()
                                            .foregroundStyle(Color.white)
                                    )
                                }
                            .onTapGesture {
                                showExerciseDescription = exercise
                            }
                            .onLongPressGesture {
                                selectedExerciseID = exercise.id
                                showDeleteTaskMenu = true
                            }
                            .confirmationDialog("Delete Exercise",
                                                isPresented: $showDeleteTaskMenu,
                                                titleVisibility: .visible) {
                                Button("Delete", role: .destructive) {
                                    if let exerciseID = selectedExerciseID {
                                        deleteExercise(exerciseID)
                                    }
                                }
                                Button("Cancel", role: .cancel) { }
                            }
                        
                            .frame(height: 100)
                        }
                    .padding()
                    //MARK: Press button to add a new Exercise to the Routine
                    Menu {
                        Button("Search in Exercise List") {
                            showExerciseList = true
                        }
                        Button("Add Exercise manually"){
                            showAddExercise = true
                        }
                        //showAddExercise = true
                    } label: {
                        VStack{
                            Label("Add a new exercise", systemImage: "plus")
                                .foregroundStyle(Color.white)
                                .font(.headline)
                                }
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
            }
            .navigationTitle(routineName)
            .sheet(item: $showExerciseDescription) {exercise in
                RoutineExerciseDescriptionView(exercise: exercise)
                }
            .sheet(isPresented: $showAddExercise) {
                AddExerciseView(data: $dataVariable)
            }
            .sheet(isPresented: $showExerciseList) {
                ExerciseListView(data: $dataVariable)
            }
            .sheet(isPresented: $finishRoutine) {
                AddRoutineView(routineName: routineName)
            }
            .background(Color.black.opacity(0.9))
            /*.toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddRoutineView()
                            .navigationTitle("Routine")
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                            }
                        }
                    }*/
                }
            }
    }
