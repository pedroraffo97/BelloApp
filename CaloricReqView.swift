//
//  CaloricReqView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 23.11.23.
//

import Foundation

import SwiftUI

struct CaloricReqView: View {
    @State var StringWeight:String = ""
    @State var StringHeight:String = ""
    @State var StringAge: String = ""
    @State var isOn = false
    @State var CaloricReqResult: Double = 0.0
    @State var NoExe: Int = 0
    @State var LowInt: Int = 0
    @State var MedInt: Int = 0
    @State var HighInt: Int = 0
    @State var MaleCaloricResult: Double = 0
    @State var FemaleCaloricResult: Double = 0
    
    func noExeSelection(){
        NoExe += 1
    }
    
    func LowIntSelection(){
        LowInt += 1
    }
    
    func MedIntSelection(){
        MedInt += 1
    }
    
    func HighIntSelection(){
        HighInt += 1
    }
    
    func calculateMaleCalReq() -> Double? {
        guard let weight = Double(StringWeight) else {
            return nil
        }
        guard let height = Double(StringHeight) else {
            return nil
        }
        guard let age = Double (StringAge) else { return nil
        }
        
        var ActiveLevelValue: Double = 0
        
        if NoExe >= 1 {
            ActiveLevelValue = 1.2
        }
        else if LowInt >= 1 {
            ActiveLevelValue = 1.375
        }
        else if MedInt >= 1 {
            ActiveLevelValue = 1.55
        }
        else if HighInt >= 1 {
            ActiveLevelValue = 1.725
        }
        let maleBMR = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
        let maleTDEE = maleBMR * ActiveLevelValue
        
        MaleCaloricResult = maleTDEE
        
        return maleTDEE
    }
    
    func calculateFemaleCalReq() -> Double? {
        guard let weight = Double(StringWeight) else {
            return nil
        }
        guard let height = Double(StringHeight) else {
            return nil
        }
        guard let age = Double (StringAge) else { return nil
        }
        
        var ActiveLevelValue: Double = 0
        
        if NoExe >= 1 {
            ActiveLevelValue = 1.2
        }
        else if LowInt >= 1 {
            ActiveLevelValue = 1.375
        }
        else if MedInt >= 1 {
            ActiveLevelValue = 1.55
        }
        else if HighInt >= 1 {
            ActiveLevelValue = 1.725
        }
        let femaleBMR = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
        
        let femaleTDEE = femaleBMR * ActiveLevelValue
        
        FemaleCaloricResult = femaleTDEE
        
        return femaleTDEE
    }
        
    
    
    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    
                    HStack{
                        Text("Weight:")
                        TextField("Enter your current Weight",text: $StringWeight)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Height:")
                        TextField("Enter your current Height",text: $StringHeight)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Age:")
                        TextField("Enter your current Age",text: $StringAge)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(10)
                }
                .padding()
                VStack{
                    HStack{
                        Text("Training Intensity:")
                            .font(.title3)
                            .padding()
                        Spacer()
                    }
                    Button{
                        noExeSelection()
                    } label:{
                        HStack{
                            Image(systemName: "gauge.with.dots.needle.bottom.0percent")
                            Text("No Exercise")
                        }
                    }
                    .padding(5)
                    Button{
                        LowIntSelection()
                    } label:{
                        HStack{
                            Image(systemName: "gauge.with.dots.needle.33percent")
                            Text("Low Intensity")
                        }
                    }
                    .padding(5)
                    Button{
                        MedIntSelection()
                    } label:{
                        HStack{
                            Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                            Text("Medium Intensity")
                        }
                    }
                    .padding(5)
                    Button{
                        HighIntSelection()
                    } label:{
                        HStack{
                            Image(systemName: "gauge.with.dots.needle.bottom.100percent")
                            Text("High Intensity")
                        }
                    }
                    .padding(5)
                    }
                .padding()
                VStack {
                    Button{
                        calculateMaleCalReq()
                        calculateFemaleCalReq()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 300, height: 30)
                                .scaledToFit()
                                .overlay(
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 1)
                                )
                            HStack{
                                Text("Calculate Caloric Requirement")
                                    }.colorMultiply(.black)
                            }
                        }
                    }
                .padding()
                VStack {
                    Text("Results").font(.headline)
                    HStack{
                        Text("Male: ")
                        Text(String(MaleCaloricResult))
                    }
                    .padding(5)
                    HStack{
                        Text("Female: ")
                        Text(String(FemaleCaloricResult))
                    }
                    .padding(5)
                }
                .padding()
                }
            
            }
        }
    }

struct CaloricReqView_previews: PreviewProvider{
    
    static var previews: some View{
        CaloricReqView()
    }
}
