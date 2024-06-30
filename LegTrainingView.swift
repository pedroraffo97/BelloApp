//
//  LegTrainingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct LegTrainingView: View {
    @EnvironmentObject var data: Routine
    @EnvironmentObject var routinetracker: RoutineTracker
    var body: some View {
        VStack {
            List{
                ForEach(data.leg_exercises) {exercise in
                    NavigationLink{
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
                                YoutubeVideoView(videoID: exercise.videolink)
                                    .frame(width: 300, height: 200, alignment: .center)
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
                    data.leg_exercises.remove(atOffsets: indexSet)
                })
                NavigationLink("Add a new exercise"){
                    AddLegExerciseView().navigationTitle("New exercise")
                }
            }.toolbar {
                ToolbarItem {
                    NavigationLink("Add new training"){
                        AddRoutineView()
                            .navigationTitle("Routine")
                    }
                }
            }
        }
    }
}

struct LegTrainingView_previews: PreviewProvider {
    static var previews: some View{
        LegTrainingView()
            .environmentObject(RoutineTracker())
            .environmentObject(Routine())
    }
}
