//
//  AddExercisefromListView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 31.03.25.
//

import Foundation

import SwiftUI

struct AddExercisefromListView: View {
    @Environment(\.dismiss) var dismiss
    var exercise: Exercise
    @Binding var data: [Exercise]
    
    var body: some View {
        NavigationView {
        ScrollView {
            LazyVStack {
                Image(exercise.display)
                    .resizable()
                    .scaledToFit()
                    .frame(width:  100, height: 100, alignment: .center)
                    .padding()
                HStack {
                    Text("Muscle Group: ")
                        .bold()
                    Text(exercise.bodypart)
                }
                    .padding()
                Text(exercise.information)
                    .padding()
                HStack{
                    Image(exercise.displayInstructions)
                        .resizable()
                        .scaledToFit()
                        .frame(width:   200, height: 200, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.1))
                                .shadow(color: Color.white.opacity(0.2), radius: 5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
                .padding()
                Text(exercise.execution)
                    .padding()
                YoutubeVideoView(videoID: exercise.videolink)
                    .frame(width: 300, height: 200, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.1))
                            .shadow(color: Color.white.opacity(0.2), radius: 5)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
            }
            .background(Color.black.opacity(0.9))
            .foregroundStyle(Color.white)
            .navigationTitle(exercise.name)
            .toolbar {
                ToolbarItem{
                    Button {
                        //MARK: This plus will add the exercise to the current Training
                        data.append(exercise)
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.white)
                        }
                    }
                }
            }
        }
    }
}
