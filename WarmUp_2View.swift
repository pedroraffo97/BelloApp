//
//  WarmUp_2View.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 10.12.23.
//

import Foundation

import SwiftUI

struct WarmUpView_2: View {
    @EnvironmentObject var data: Routine
    var body: some View {
        VStack{
            Text("Warm up")
                .font(.title2)
                .bold()
            Text("5 minutes")
            TimerView()
            
            Text("Warm Up Exercises")
                .font(.title2)
                .bold()
                .padding()
            
            ForEach(data.warm_up_exercises_2.indices, id: \ .self ){index in
                let exercise = data.warm_up_exercises_2[index]
                HStack{
                    //Image of the exercise
                    Image(exercise.display)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding()
                    VStack{
                        //Repetitions
                        TextField(exercise.repetition, text: $data.warm_up_exercises_2[index].repetition)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .padding()
                        //Name of the exercise and info
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
                    }
                    VStack{
                        //Checkbox when done
                        CheckboxView()
                            .padding()
                        //Delete Button
                        Button {
                            data.warm_up_exercises_2.remove(at: index)
                        } label: {
                            Image("remove")
                                .resizable()
                                .scaledToFit()
                                .frame(width:   20, height: 20, alignment: .center)
                                .padding()
                        }
                    }
                }
                Divider()
                    .padding()
            }
            Divider()
                .padding()
        }
    }
}

struct WarmUpView_2_Preview: PreviewProvider {
    static var previews: some View{
        WarmUpView_2().environmentObject(Routine())
    }
}
