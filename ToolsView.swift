//
//  ToolsView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 18.11.23.
//

import Foundation

import SwiftUI

enum ToolType: String, CaseIterable {
    case trainer = "Coach"
    case bodyfatindex = "Body Fat Index"
    case onerepmax = "Max Weight One Repetition"
    case caloricreq = "Caloric Requirements"
    case bmitips = "BMI Training Tips"
    case amrcalculation = "AMR Calculation"
    
    var iconName: String {
        switch self {
        case .trainer: return "coach"
        case .bodyfatindex: return "body-fat"
        case .onerepmax: return "repetition"
        case .caloricreq: return "calories"
        case .bmitips: return "bmi"
        case .amrcalculation: return "metabolism"
        }
    }
    
    @ViewBuilder
    var destination: some View {
            switch self {
            case .trainer: TrainerView().navigationTitle("Coach")
            case .bodyfatindex:
                BodyFatView()
                    .navigationTitle("Body Fat Index")
            case .onerepmax:
                OneRepMaxView()
                    .navigationTitle("One Max Repetition")
            case .caloricreq:
                CaloricReqView()
                    .navigationTitle("Caloric Requirement")
            case .bmitips:
                TrainingRecomView()
                    .navigationTitle("BMI Training Tips")
            case .amrcalculation:
                CalculateAMR()
                    .navigationTitle("Calculate AMR")
            }
        }
        
    }

struct ToolsView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(ToolType.allCases, id: \.self) {
                        toolType in
                        NavigationLink {
                            toolType.destination
                        } label: {
                            GeometryReader {
                                geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(uiColor: .systemGray4))
                                    .frame(width: geometry.size.width, height: 180)
                                    .overlay(
                                        VStack {
                                            Image(toolType.iconName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .padding()
                                            Text(toolType.rawValue)
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
            .navigationTitle("Tools")
        }
    }
}


struct ToolsView_Preview: PreviewProvider {
        static var previews: some View {
            ToolsView()
        }
    }
