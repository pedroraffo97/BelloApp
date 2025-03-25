//
//  TrainingRouteView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 24.03.25.
//

//
//  ChestTrainingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct TrainingRouteView: View {
    @EnvironmentObject var data: Routine
    @EnvironmentObject var routinetracker: RoutineTracker
    
    @State var showExerciseDescription: Exercise? = nil
    @State var showAddExercise: Bool = false
    @State var finishRoutine: Bool = false
    @State private var showDeleteTaskMenu: Bool = false
    @State private var selectedExerciseID: UUID? = nil
    
    func deleteExercise(_ exerciseID: UUID) {
        if let index = data.chest_exercises.firstIndex(where: {$0.id == exerciseID}) {
            data.chest_exercises.remove(at: index)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 1)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(data.chest_exercises, id: \.self) {
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
                    //MARK: Add a new Exercise to the Routine
                    Button {
                        showAddExercise = true
                    } label: {
                        VStack{
                            Label("Add a new exercise", systemImage: "plus")
                                .foregroundStyle(Color.white)
                                .font(.headline)
                                }
                            }
                            .padding()
                    Button {
                        finishRoutine = true
                    } label: {
                        Label("Finish Routine", systemImage: "checkmark.circle")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                    .foregroundStyle(Color.white)
                    .textFieldStyle(.plain)
                    .frame(width: 200, height: 40)
                    .cornerRadius(8)
                    .background(Color.black)
                    .padding()
                }
            }
            .navigationTitle("Chest Training")
            .sheet(item: $showExerciseDescription) {exercise in
                RoutineExerciseDescriptionView(exercise: exercise)
                }
            .sheet(isPresented: $showAddExercise) {
                AddChestExerciseView()
            }
            .sheet(isPresented: $finishRoutine) {
                AddRoutineView(routineName: "Chest Training")
            }
            .background(Color.black.opacity(0.9))
            .toolbar {
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
                    }
                }
            }
    }
