//
//  NewRoutineView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 14.11.23.
//

import Foundation

import SwiftUI


struct NewRoutineView: View {
    @EnvironmentObject var data: Routine
    @EnvironmentObject var exerciseglossary: ExerciseGlossary
    @EnvironmentObject var routinetracker: RoutineTracker
    var body: some View {
        VStack{
            List{
                ForEach(data.new_routine){
                    exercise in NavigationLink{
                        ScrollView{
                            LazyVStack {
                                Text("Information")
                                    .font(.title)
                                Image(exercise.display)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:   50, height: 50, alignment: .center)
                                    .padding()
                                Text(exercise.name)
                                    .padding(0.05)
                                    .font(.headline)
                                Text(exercise.bodypart)
                                    .font(.callout)
                                    .padding()
                                Text(exercise.information)
                                    .padding()
                                Text(exercise.execution)
                                    .padding()
                            }}} label:{
                                HStack {
                                    Image(exercise.display)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .padding()
                                    Text(exercise.repetition)
                                        .padding()
                                    Text(exercise.name)
                                        .padding()
                                }
                            }
                }.onDelete(perform: { indexSet in
                    data.new_routine.remove(atOffsets: indexSet)
                })
            }.toolbar {
                ToolbarItem{
                    NavigationLink("Add new training") {
                        AddRoutineView()
                            .navigationTitle("Routine")
                    }
                }
            }
            
        }
    }
}

struct NewRoutineView_previews: PreviewProvider {
    static var previews: some View{
        NewRoutineView()
            .environmentObject(RoutineTracker())
            .environmentObject(Routine())
            .environmentObject(ExerciseGlossary())
    }
}
