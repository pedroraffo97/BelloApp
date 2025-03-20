//
//  ExerciseView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 19.03.25.
//
import Foundation

import SwiftUI

struct ExerciseView: View {
    var exercise: Exercise
    var data: Routine
    
    var body: some View {
        NavigationView {
        ScrollView {
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
                HStack{
                    Image(exercise.displayInstructions)
                        .resizable()
                        .scaledToFit()
                        .frame(width:   200, height: 200, alignment: .center)
                        .padding()
                }
                .padding()
                Text(exercise.information)
                    .padding()
                Text(exercise.execution)
                    .padding()
                YoutubeVideoView(videoID: exercise.videolink)
                    .frame(width: 300, height: 200, alignment: .center)
                    .padding()
            }
            .navigationTitle(exercise.name)
            .toolbar {
                ToolbarItem{
                    Menu("Add") {
                        Button{
                            data.new_routine
                                .append(exercise)
                        } label:{
                            Text("new Lifting Routine")
                        }
                        Button("HIIT session 1"){
                            data.HIITSession1.append(exercise)
                        }
                        Button("HIIT session 2"){
                            data.HIITSession2.append(exercise)
                        }
                        Button("HIIT session 3"){
                            data.HIITSession3.append(exercise)
                            }
                        }
                    }
                }
            }
        }
    }
}
