///
//  ExerciseGlossaryView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 04.11.23.
//

import Foundation

import SwiftUI

struct ExerciseGlossaryView: View {
    @EnvironmentObject var exerciseglossary: ExerciseGlossary
    @EnvironmentObject var data: Routine
    @State private var searchText: String = ""
    @State var selectRoutine: String = ""
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exerciseglossary.ExerciseGuide
        }
        else {
            return exerciseglossary.ExerciseGuide.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                exercise.bodypart.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                exercise.display.localizedCaseInsensitiveContains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
            VStack{
                NavigationView{
                    List{
                        ForEach(filteredExercises, id: \.self){exercise in
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
                            } label: {
                                HStack{
                                    Image(exercise.display)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .padding(50)
                                    VStack{
                                        Text(exercise.name)
                                        Text(exercise.bodypart)
                                            .font(.footnote)
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Exercise Glossary")
                    .searchable(text: $searchText)
                    
                }
            }
        }
    }
struct ExerciseGlossaryView_Previews: PreviewProvider {
        static var previews: some View {
            ExerciseGlossaryView()
                .environmentObject(ExerciseGlossary())
        }
    }
