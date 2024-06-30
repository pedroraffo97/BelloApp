//
//  UserInformationClass.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

class UserInformation: ObservableObject {
    @Published var UserInformationDataBase: [User] = [
        User(name: "Mr Example", age: 0, sex: "M", weight:0, height: 0, amr: 0)]
    func save_UserInformation(){
        do{
            let fileURL = try getUserInformationFileURL()
            let data = try JSONEncoder().encode(UserInformationDataBase)
            try data.write(to:fileURL)
            print("User Information saved!")
            
        }
        catch{
            print("Unable to save \(error)")
        }
    }
    func load_UserInformation(){
        do {
            let fileURL = try getUserInformationFileURL()
            let data = try Data(contentsOf: fileURL)
            UserInformationDataBase = try JSONDecoder().decode([User].self, from: data)
            print("User Information loaded: \(UserInformationDataBase.count)")
        }
        catch{
            print("Unable to load user information: \(error)")
        }
    }
    
}

struct User : Identifiable, Decodable, Encodable, Equatable {
    var name: String = ""
    var age: Double = 0.0
    var sex: String = ""
    var weight: Double = 0.0
    var height: Double = 0.0
    var amr: Double = 0.0
    var hip: Double = 0.0
    var bai: Double = 0.0
    var id = UUID()
    
    var bmi: Double {
        return (weight / (height * height)) * 10000
    }
    
    var MaleBMR: Double {
        let WeightCalculation = 88.362 + (13.397 * weight)
        let HeightCalculation = 4.799 * height
        let AgeCalculation = 5.677 * age
        return WeightCalculation + HeightCalculation + AgeCalculation
    }
    
    var FemaleBMR: Double {
        let WeightCalculation = 447.593 + (9.247 * weight)
        let HeightCalculation = 3.098 * height
        let AgeCalculation = 4.330 * age
        return WeightCalculation + HeightCalculation + AgeCalculation
    }
    var TDEE: Double {
        return MaleBMR + amr
    }
}

//FileManager function for the UserInformation
private func getUserInformationFileURL() throws -> URL{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("UserInformationDataBase.json")
}
