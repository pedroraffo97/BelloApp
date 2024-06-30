//
//  HIITTrainingPortfolioView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 10.12.23.
//

import Foundation
import SwiftUI

struct HIITTrainingPortfolioView: View {
    var body: some View {
        List{
            VStack{
                NavigationLink{
                    SweatHIITView()
                        .navigationTitle("💦 Sweat HIIT Training")
                } label: {
                    Text("💦 Sweat HIIT Training")
                }
                .padding()
            }
            VStack{
                NavigationLink{
                    PowerHIITView()
                        .navigationTitle(" 💪🏽 Power HIIT Training")
                } label: {
                    Text("💪🏽 Power HIIT Training")
                }
                .padding()
            }
        }
    }
}


struct HIITTrainingPortfolioView_Preview: PreviewProvider {
    static var previews: some View {
        HIITTrainingPortfolioView()
    }
}
