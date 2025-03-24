//
//  NewTrainingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI


enum RoutineType: String, CaseIterable, Identifiable {
    case chest = "Chest"
    case back = "Back"
    case legs = "Legs"
    case boost = "Boost"
    case yourtraining = "Your Training"
    
    var id: String {
        rawValue
        }
    
    var iconName: String {
        switch self {
        case .chest: return "chest"
        case .back: return "back"
        case .legs: return "leg"
        case .boost: return "boost"
        case .yourtraining: return "dumbbells"
            }
        }
    
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .chest: TrainingRouteView()
        case .back: BackTrainingView()
        case .legs: LegTrainingView()
        case .boost: PotenceTrainingView()
        case .yourtraining: NewRoutineView()
            }
        }
    }

struct NewTrainingView: View {
    @State private var selectedRoutine: RoutineType? = nil
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                Text("Select the Training you prefer o create a customized one!")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(RoutineType.allCases, id: \.self) {
                        routineType in
                        Button {
                            selectedRoutine = routineType
                        } label: {
                            GeometryReader {
                                geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.8))
                                    .shadow(radius: 1.5)
                                    .frame(width: geometry.size.width, height: 180)
                                    .overlay(
                                        VStack {
                                            Image(routineType.iconName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .padding()
                                            Text(routineType.rawValue)
                                                .font(.title2)
                                                .bold()
                                        }
                                        .foregroundStyle(Color.white)
                                    )
                                    }
                                }
                                .frame(height: 180)
                            }
                        }
                        .padding()
                    }
            .background(Color.black.opacity(0.9))
            .sheet(item: $selectedRoutine) {
                selectedRoutine in
                    selectedRoutine.destinationView
            }
            .navigationTitle("Training")
                }
            }
        }



struct NewTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrainingView()
    }
}
