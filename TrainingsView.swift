//
//  TrainingsView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 18.11.23.
//

import Foundation

import SwiftUI

struct TrainingsView: View {
    @State private var selectedTraining: TrainingType? = nil
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                LazyVGrid (columns: columns, spacing: 10) {
                    ForEach(TrainingType.allCases, id: \.self) {
                        trainingType in
                        Button {
                            selectedTraining = trainingType
                        } label: {
                            GeometryReader {
                                geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.8))
                                    .shadow(radius: 1.5)
                                    .frame(width: geometry.size.width, height: 180)
                                    .overlay(
                                        VStack {
                                            Image(systemName: trainingType.iconName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.white.opacity(0.5))
                                            Text(trainingType.rawValue)
                                                .font(.title2)
                                                .bold()
                                                .foregroundColor(.white)
                                        }
                                    )
                            }
                        }
                        .frame(height: 180)
                    }
                }
                .padding()
            }
            .navigationTitle("Trainings")
            .background(Color.black.opacity(0.9))
            .sheet(item: $selectedTraining) {
                trainingType in trainingType.destinationView
            }
        }
    }
}

enum TrainingType: String, CaseIterable, Identifiable {
    case training = "Training"
    case crossfit = "Crossfit"
    case hiit = "HIIT"
    case finished = "Finished"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .training: return "figure.strengthtraining.traditional"
        case .crossfit: return "figure.cross.training"
        case .hiit: return "figure.step.training"
        case .finished: return "figure.run.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .training: return .gray
        case .crossfit: return .red
        case .hiit: return .yellow
        case .finished: return .blue
        }
    }
    
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .training: NewTrainingView()
        case .crossfit: CrossfitTrainingView()
        case .hiit: HIITTrainingPortfolioView()
        case .finished: CurrentTrainingView()
            
        }
    }

}

struct TrainingsView_previews: PreviewProvider {
    static var previews: some View{
        TrainingsView()
    }
}
