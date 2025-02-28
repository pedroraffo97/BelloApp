//
//  TrainingsView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 18.11.23.
//

import Foundation

import SwiftUI

struct TrainingsView: View {
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                LazyVGrid (columns: columns, spacing: 10) {
                    ForEach(TrainingType.allCases, id: \.self) {
                        trainingType in
                        NavigationLink {
                            trainingType.destinationView
                        } label: {
                            GeometryReader {
                                geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(trainingType.color.gradient)
                                    .frame(width: geometry.size.width, height: 180)
                                    .overlay(
                                        VStack {
                                            Image(systemName: trainingType.iconName)
                                                .font(.largeTitle)
                                            Text(trainingType.rawValue)
                                                .font(.headline)
                                        }
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .frame(height: 180)
                    }
                }
                .padding()
            }
            .navigationTitle("Trainings")
        }
    }
}

enum TrainingType: String, CaseIterable {
    case training = "Training"
    case crossfit = "Crossfit"
    case hiit = "HIIT"
    case finished = "Finished"
    
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
        case .training: NewTrainingView().navigationTitle("New Training")
        case .crossfit: CrossfitTrainingView().navigationTitle("Crossfit")
        case .hiit: HIITTrainingPortfolioView().navigationTitle("HIIT")
        case .finished: CurrentTrainingView().navigationTitle("Finished")
            
        }
    }

}

struct TrainingsView_previews: PreviewProvider {
    static var previews: some View{
        TrainingsView()
    }
}
