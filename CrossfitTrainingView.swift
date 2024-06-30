//
//  CrossfitTrainingView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 28.11.23.
//

import Foundation

import SwiftUI

struct CrossfitTrainingView: View {
    
    var body: some View {
        
        ScrollView{
            VStack{
                Text("Crossfit Training")
                    .padding()
                Text("Stretching")
                    .padding()
                YoutubeVideoView(videoID: "watch?v=kT5OXi1PAfA")
                    .frame(width: 300, height: 200)
            }
        }
    }
}



struct CrossfitTrainingView_Preview: PreviewProvider {
    static var previews: some View {
        CrossfitTrainingView()
    }
}
