//
//  FinishedTrainingUnitView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 01.04.25.
//

import Foundation

import SwiftUI

struct FinishedTrainingUnitView: View {
    var training: TrainingLog
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(training.kcal + "KCAL")
                            .font(.title)
                            .bold()
                            .padding()
                            .foregroundColor(.yellow)
                        Spacer()
                        Text(training.day)
                            .font(.headline)
                            .bold()
                            .padding()
                            .foregroundColor(.white)
                    }
                    let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(training.group, id: \.self) { exercise in
                            GeometryReader { geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                                    .shadow(radius: 1.5)
                                    .frame(width: geometry.size.width, height: 180)
                                    .overlay(
                                        VStack {
                                            Image("")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .padding()
                                            Text(exercise)
                                                .foregroundStyle(Color.white)
                                                .font(.headline)
                                                .bold()
                                                .padding()
                                                }
                                        )
                                    }
                                }
                                .frame(height: 180)
                            }
                            .padding(15)
                        }
                    }
            .navigationTitle(training.name)
            .background(Color.black.opacity(0.9))
        }
    }
}
