//
//  1RepMaxView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 22.11.23.
//

import Foundation

import SwiftUI

struct OneRepMaxView: View {
    @State var StringWeight: String = ""
    @State var StringRepetitions: String = ""
    @State var result: Double = 0.0
    func CalculateOneRepMax() -> Double? {
        
        guard let weight = Double(StringWeight) else { return nil}
        guard let repetitions = Double(StringRepetitions) else {return nil }
        let oneRepMax:Double = weight * (1 + 0.0333 * repetitions)
        result = oneRepMax
        return oneRepMax
    }
    var body: some View {
        ScrollView{
            VStack{
                Text("""
    One rep maximum (one repetiion maximum or 1RM) in weight
    training is the maximum amount of weight one can lift in
    a single repetition for a given exercise. One repetition
    maximum can be used for determining and individual's
    maximum strength.
    """)
                .padding(10)
                
                VStack{
                    HStack{
                        Text("Weight:")
                        TextField("Weight",text: $StringWeight)
                        .textFieldStyle(.roundedBorder)}
                    .padding()
                    HStack{
                        Text("Repetitions:")
                        TextField("Repetitions:", text: $StringRepetitions)
                        .textFieldStyle(.roundedBorder)}
                    .padding()
                }
                Button{
                    CalculateOneRepMax()
                } label:{
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 20, 
                                   height: 10))
                            .foregroundColor(.white)
                            .frame(width: 150, 
                                   height: 30)
                            .scaledToFit()
                            .overlay(
                                RoundedRectangle(
                                    cornerSize: CGSize(
                                        width:20,
                                        height:10)).stroke(Color.black))
                        Text("Calculate")
                            .colorMultiply(.black)
                            
                    }
                }
                .padding()
                VStack{
                    HStack{
                        Text("1 Rep Max: ")
                        Text(String(result))
                    }.font(.headline)
                    
                }
            }
        }
    }
    
}


struct OneRepMaxView_preview: PreviewProvider{
    static var previews: some View {
        OneRepMaxView()
    }
}
