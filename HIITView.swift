//
//  HIITView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 28.11.23.
//

import Foundation

import SwiftUI

struct warmUpView: View {
    @EnvironmentObject var data: Routine
    var body: some View {
        VStack{
            Text("Warm up")
                .font(.title2)
                .bold()
            Text("5 minutes")
            
            TimerView()
            
            ForEach(data.warm_up_exercises){exercise in
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
                                ZStack{
                                    Rectangle()
                                        .stroke()
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
                                .colorMultiply(.black)
                            }
                }.onDelete(perform: {indexSet in
                    data.warm_up_exercises.remove(atOffsets:indexSet)
                })
                }
            }
    }
struct HIITTrainingView: View {
    @EnvironmentObject var data: Routine
    
    var body: some View {
        VStack{
            Text("Core Training")
                .font(.title2)
                .bold()
            Text("40 minutes")
            
            TimerView()
            
            ForEach(data.hiit_exercises){exercise in
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
                                ZStack{
                                    Rectangle()
                                        .stroke()
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
                                .colorMultiply(.black)
                            }
                }.onDelete(perform: {indexSet in
                    data.hiit_exercises.remove(atOffsets:indexSet)
                })
            }
        }
    }

struct stretchingView:View {
    @EnvironmentObject var data: Routine
    
    var body: some View {
        VStack{
            Text("Stretching")
                .font(.title2)
                .bold()
            Text("10 minutes")
            
            TimerView()
            
            ForEach(data.stretching_exercises){exercise
                in
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
                                ZStack{
                                    Rectangle()
                                        .stroke()
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
                                .colorMultiply(.black)
                            }
                }.onDelete(perform: {indexSet in
                    data.stretching_exercises.remove(atOffsets:indexSet)
                })
            
        }
    }
}
struct HIITView: View {
    @EnvironmentObject var data: Routine
    
    var body: some View {
        ScrollView{
            VStack {
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


struct HIITView_Preview: PreviewProvider {
    static var previews: some View {
        HIITView().environmentObject(Routine())
    }
}
