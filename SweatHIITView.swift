//
//  SweatHIITView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 10.12.23.
//

import Foundation

import SwiftUI

struct HIITTrainingView: View {
    @EnvironmentObject var data: Routine
    
    var body: some View {
        VStack{
            Text("Core Training")
                .font(.title2)
                .bold()
            Text("40 minutes")
            
            TimerView()
            
            ForEach(data.hiit_exercises.indices, id: \.self ){index in
                let exercise = data.hiit_exercises[index]
                HStack{
                    //
                    Image(exercise.display)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding()
                    //
                    TextField(exercise.repetition, text: $data.hiit_exercises[index].repetition)
                        .padding()
                    //
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
                                        Text(exercise.name)
                                    }
                            }
                    //
                    CheckboxView()
                        .padding()
                            }
                }.onDelete(perform: {indexSet in
                    data.hiit_exercises.remove(atOffsets:indexSet)
                })
            }
        }
    }

struct SweatHIITView: View {
    @EnvironmentObject var data: Routine
    var body: some View {
        ScrollView{
            LazyVStack {
                warmUpView()                    
                    .padding()
                HIITTrainingView()
                    .padding()
                stretchingView()
                    .padding()
                }
            }
        }
    }
        

        
struct SweatHIITView_Previews: PreviewProvider {
    static var previews: some View {
        SweatHIITView()
                .environmentObject(Routine())
        }
    }
