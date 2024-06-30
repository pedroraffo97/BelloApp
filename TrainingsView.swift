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
            List{
                NavigationLink {
                    NewTrainingView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                    Text("Fitness Training")
                }
                NavigationLink {
                    CurrentTrainingView()
                } label:{
                    Image(systemName: "figure.run.circle.fill")
                    Text("Finished")
                }
                NavigationLink {
                    CrossfitTrainingView()
                        .navigationTitle("CrossFit Training")
                } label: {
                    Image(systemName: "figure.cross.training")
                    Text("CrossFit Training")
                }
                NavigationLink {
                    HIITTrainingPortfolioView()
                        .navigationTitle("High Interval Training Portfolio")
                } label: {
                    Image(systemName: "figure.step.training")
                    Text("High Interval Training")
                }
             }
        }
   }

struct TrainingsView_previews: PreviewProvider {
    static var previews: some View{
        TrainingsView()
    }
}
