//
//  RowMenuView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 14.04.25.
//

import SwiftUI

import Foundation

struct RowMenuView:  View {
    @State private var selectedRow: RowType? = nil
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                LazyVGrid (columns: columns, spacing: 10) {
                    ForEach(RowType.allCases, id: \.self) {
                        trainingType in
                        Button {
                            selectedRow = trainingType
                        } label: {
                            GeometryReader {
                                geometry in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.8))
                                    .shadow(radius: 1.5)
                                    .frame(width: geometry.size.width, height: 180)
                                    .overlay(
                                        VStack {
                                            Spacer()
                                            HStack{
                                                Image(trainingType.iconName)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 120, height: 100)
                                                Spacer()
                                            }
                                            //.padding()
                                            /*Text(trainingType.rawValue)
                                                .font(.title2)
                                                .bold()
                                                .foregroundColor(.white)*/
                                        }
                                    )
                            }
                        }
                        .frame(height: 180)
                    }
                }
                .padding()
            }
            .navigationTitle("Row")
            .background(Color.black.opacity(0.9))
            .sheet(item: $selectedRow) {
                trainingType in trainingType.destinationView
            }
        }
    }
}

enum RowType: String, CaseIterable, Identifiable {
    case strongRow = "Strong Row"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .strongRow: return "strongRow"
        }
    }
    
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .strongRow: StrongRowView()
            
        }
    }

}


struct RowMenuView_Previews: PreviewProvider {
    static var previews: some View {
        RowMenuView()
    }
}
