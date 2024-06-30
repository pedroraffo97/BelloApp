//
//  HIITCoreTraining2View.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 10.12.23.
//

import Foundation

import SwiftUI


struct HIITCoreTraining2Session1View: View {
    @EnvironmentObject var data: Routine
    var body: some View {
        
        ForEach(data.HIITSession1.indices, id: \ .self){index in
            let exercise = data.HIITSession1[index]
            HStack{
                //Image of the exercise
                Image(exercise.display)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding()
                VStack{
                    //Repetitions
                    TextField(exercise.repetition, text: $data.HIITSession1[index].repetition)
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
                        data.HIITSession1.remove(at: index)
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
        NavigationLink("Add a new exercise"){
            AddHIITExerciseView().navigationTitle("New exercise")
        }
        .padding()
        Divider()
            .padding()
        }
    }

struct HIITCoreTraining2Session2View: View {
    @EnvironmentObject var data: Routine
    var body: some View {
        
        ForEach(data.HIITSession2.indices, id: \ .self){index in
            let exercise = data.HIITSession2[index]
            HStack{
                //
                Image(exercise.display)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding()
                VStack{
                    //
                    TextField(exercise.repetition, text: $data.HIITSession2[index].repetition)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
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
                }
                //
                VStack{
                    CheckboxView()
                        .padding()
                    //
                    Button {
                        data.HIITSession2.remove(at: index)
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
        NavigationLink("Add a new exercise"){
            AddHIITExerciseView().navigationTitle("New exercise")
        }
        .padding()
        Divider()
            .padding()
        }
}
    
    struct HIITCoreTraining2Session3View: View {
        @EnvironmentObject var data: Routine
        var body: some View {
            ForEach(data.HIITSession3.indices, id: \ .self){index in
                let exercise = data.HIITSession3[index]
                HStack{
                    //
                    Image(exercise.display)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding()
                    //
                    TextField(exercise.repetition, text: $data.HIITSession3[index].repetition)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
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
                    VStack{
                        //
                        CheckboxView()
                            .padding()
                        //Delete Button
                        Button {
                            data.HIITSession3.remove(at: index)
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
            NavigationLink("Add a new exercise"){
                AddHIITExerciseView().navigationTitle("New exercise")
            }
            .padding()
            Divider()
                .padding()
            }
    }


struct HIITCoreTraining2View: View {
    @EnvironmentObject var data: Routine
    
    var body: some View {
        VStack{
            Text("Core Training")
                .font(.title2)
                .bold()
            Text("40 minutes")
            TimerView()
            Text("Core Exercises")
                .font(.title2)
                .bold()
                .padding()
            //Session 1
            Text("Session 1")
                .font(.headline)
                .padding()
            HIITCoreTraining2Session1View()
            //Session 2
            Text("Session 2")
                .font(.headline)
            HIITCoreTraining2Session2View()
            //Session 3
            Text("Session 3")
                .font(.headline)
            HIITCoreTraining2Session3View()
        }
    }
}
    
    struct HIITCoreTraining2View_Preview: PreviewProvider {
        static var previews: some View {
            HIITCoreTraining2View().environmentObject(Routine())
        }
    }

struct HIITCoreTraining2Session3View_Preview: PreviewProvider {
    static var previews: some View{
        HIITCoreTraining2Session3View().environmentObject(Routine())
    }
}
