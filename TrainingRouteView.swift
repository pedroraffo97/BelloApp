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
    /*var exercise: Exercise
    var addexercise: ViewBuilder
    var title: String
    var exerciseGroup: [Exercise]*/
    @EnvironmentObject var data: Routine
    @EnvironmentObject var routinetracker: RoutineTracker
    
    @State var showExerciseDescription: Exercise? = nil
    @State private var showDeleteTaskMenu: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 1)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(data.chest_exercises, id: \.self) {
                        exercise in
                        Button {
                            showExerciseDescription = exercise
                        } label: {
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
                                .onLongPressGesture {
                                    showDeleteTaskMenu = true
                                }
                                /*.actionSheet(isPresented: $showDeleteTaskMenu){
                                    ActionSheet(
                                        title: Text("Delete Exercise"),
                                        message: Text("Are you sure you want to delete this exercise from your routine?"),
                                        buttons: [
                                            .destructive(Text("Delete")){
                    
                                            }
                                            .cancel()
                                            ]
                                        )
                                    }*/
                            }
                            .frame(height: 100)
                        }
                    .padding()
                    //MARK: Add a new Exercise to the Routine
                    NavigationLink {
                        AddChestExerciseView()
                    } label: {
                        /*GeometryReader {
                            geometry in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .shadow(radius: 1.5)
                                .frame(height: 100)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Image(systemName: "plus")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .bold()
                                            Text("Add a new exercise")
                                                .font(.headline)
                                        }
                                        .padding()
                                        .foregroundStyle(Color.white)
                                        .background(Color.black)
                                    }
                                    )
                                }*/
                        VStack{
                            Label("Add a new exercise", systemImage: "plus")
                                .foregroundStyle(Color.white)
                                .font(.headline)
                                }
                            }
                            .padding()
                    /*NavigationLink {
                        AddChestExerciseView()
                    } label: {
                        GeometryReader {
                            geometry in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .shadow(radius: 1.5)
                                .frame(height: 100)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Image(systemName: "plus")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .bold()
                                            Text("Add a new exercise")
                                                .font(.headline)
                                        }
                                        .padding()
                                        .foregroundStyle(Color.white)
                                        .background(Color.black)
                                    }
                                    )
                                }
                            }
                            .padding()*/
                        }
                    }
            .navigationTitle("Chest Training")
            .sheet(item: $showExerciseDescription) {exercise in
                RoutineExerciseDescriptionView(exercise: exercise)
                }
            .background(Color.black.opacity(0.9))
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddRoutineView()
                            .navigationTitle("Routine")
                    } label: {
                        Label("Add Routine", systemImage: "plus")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                            }
                        }
                    }
                }
            }
    }
