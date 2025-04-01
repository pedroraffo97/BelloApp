//
//  FinishedTrainingLogView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 01.04.25.
//

import Foundation

import SwiftUI

struct FinishedTrainingLogView: View {
    @EnvironmentObject var routinetracker: RoutineTracker
    @State private var selectedRoutine: TrainingLog?
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    let columns = Array(repeating: GridItem(spacing: 10), count: 1)
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(routinetracker.FinishedTrainings) { training in
                            Button {
                                selectedRoutine = training
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                                    .frame(width: 350, height: 80)
                                    .overlay(
                                        VStack(alignment: .leading, spacing: 8){
                                            Text(training.name)
                                                .font(.title2)
                                                .bold()
                                                .foregroundStyle(Color.white)
                                            HStack{
                                                Text(training.kcal + "KCAL")
                                                    .font(.title3)
                                                    .bold()
                                                    .foregroundColor(.yellow)
                                                Spacer()
                                                Text(training.day)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 10)
                                    )
                                }
                            }
                        /*.onDelete { indexSet in
                            routinetracker.FinishedTrainings.remove(atOffsets: indexSet)
                            for index in indexSet {
                                let traininglog = routinetracker.FinishedTrainings[index]
                                routinetracker.deleteTrainingLogfromFirestore(traininglog: traininglog)
                            }
                        }*/
                        }
                        .padding(15)
                    }
                }
            .navigationTitle("Training Log")
            .background(Color.black.opacity(0.9))
            .sheet(item: $selectedRoutine) {
                training in
                FinishedTrainingUnitView(training: training)
            }
        }
    }
}

#Preview {
    let mockTracker = RoutineTracker()
    mockTracker.FinishedTrainings = [
        TrainingLog(name: "Full Body Blast", day: "Monday", kcal: "450", exercises: "Pushups, Squats", group: ["Pushups", "Squats"]),
        TrainingLog(name: "Cardio Burn", day: "Wednesday", kcal: "600", exercises: "Running, Jumping Jacks", group: ["Running", "Jumping Jacks", "Cycling", "Swimming", "Rowing"])
    ]
    
    return FinishedTrainingLogView()
        .environmentObject(mockTracker)
}
