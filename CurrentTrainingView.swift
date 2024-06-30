//
//  CurrentTrainingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct CurrentTrainingView: View {
    @EnvironmentObject var routinetracker: RoutineTracker
    var body: some View {
        VStack{
            Text("Finished Trainings").font(.title)
            List{
                ForEach(routinetracker.FinishedTrainings){ training in
                    VStack {
                    
                        Text("Training Name: " + training.name)
                            .padding()
                        Text("Training Day: " + training.day)
                            .padding()
                        Text("Exercises: " + training.exercises)
                            .padding()
                        Text("Kcal: " + training.kcal)
                            .padding()
                        Text("Routine:" + training.group.joined(separator: ","))
                }
                    
                }.onDelete { indexSet in
                    routinetracker.FinishedTrainings.remove(atOffsets: indexSet)
                }
            }
            
        }
        
    }
}

struct CurrentTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTrainingView()
            .environmentObject(RoutineTracker())
    }
}
