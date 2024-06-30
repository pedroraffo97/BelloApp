//
//  StretchingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 10.12.23.
//

import Foundation

import SwiftUI

struct stretchingView:View {
    @EnvironmentObject var data: Routine
    @State var randomExerciseSelection: [Exercise] = []
    
    func generateRandomExercises(){
       //Shuffle the Exercises
        var shuffledExercises = data.stretching_exercises.shuffled()
        //Ensure there are at least 5 exercises available
        guard shuffledExercises.count >= 5 else {
            return
        }
        //Select the first 5 Exercises
        randomExerciseSelection = Array(shuffledExercises.prefix(5))
    }
    
    var body: some View {
        VStack{
            Text("Stretching")
                .font(.title2)
                .bold()
            Text("10 minutes")
            
            TimerView()
            
            Text("Stretching Exercises")
                .font(.title2)
                .bold()
            Button {
                generateRandomExercises()
            } label: {
                Image(systemName: "rectangle.stack.badge.plus")
                Text("Generate Exercises")
            }.buttonStyle(.borderedProminent)
            
            ForEach(randomExerciseSelection.indices, id: \ .self){
                index in
                let exercise = data.stretching_exercises[index]
                HStack{
                    //Image of the exercise
                    Image(exercise.display)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding()
                    VStack{
                        //Repetitions
                        TextField(exercise.repetition, text: $data.stretching_exercises[index].repetition)
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
                            data.stretching_exercises.remove(at: index)
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

struct stretchingView_Previews: PreviewProvider {
    static var previews: some View {
        stretchingView()
                .environmentObject(Routine())
        }
    }
