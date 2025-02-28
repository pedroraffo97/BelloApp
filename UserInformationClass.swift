//
//  UserInformationClass.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

import FirebaseFirestore

import FirebaseAuth

import Firebase


// variables to be used in the amr calculation in the struct User()
let lightExercise: Double = 1.15
let moderateExercise: Double = 1.35
let heavyExercise: Double = 1.50
let ExtraheavyExercise: Double = 1.85

class UserInformation: ObservableObject {
    @Published var UserInformationDataBase: [User] = []
    
    //function to calculate the AMR with user
    func CalculateAMRwithUser(userID: UUID) {
        if let index = UserInformationDataBase.firstIndex(where: {$0.id == userID}) {
            UserInformationDataBase[index].CalculateAMRwithExerciseLevel()
        }
    }
    
    //function to add data to Firestore
    func addUserInformationtoFirestore(user: User) {
        //check the authentication status
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        
        //Declare reference to Firestore
        let db = Firestore.firestore()
        
        let UserValues: [String: Any] = [
            "id": user.id.uuidString,
            "name": user.name,
            "sex": user.sex,
            "age": user.age,
            "weight": user.weight,
            "height": user.height,
            "amr": user.amr,
            "hip": user.hip,
            "bai": user.bai,
            "exerciseLevel": user.exerciseLevel,
            "bmi": user.bmi,
            "MaleBMR": user.MaleBMR,
            "FemaleBMR": user.FemaleBMR,
            "TDEE": user.TDEE
        ]
        
        db.collection("users").document(userID).collection("userinformation").document(user.id.uuidString).setData(UserValues, merge: true)
        
    }
    
    //function to load data from Firestore
    func loadUserInformationtoFirestore() {
        //authenticate with the userID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        //reference to the database
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("userinformation").getDocuments{
            snapshot, error in
            //check for errors
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                //no error
                //check for the userID
                print("Your REBT data for the user ID is: \(userID) has been loaded succesfully")
                //check if snapshot is nil
                if let snapshot = snapshot {
                    //Retrieve the documents
                    self.UserInformationDataBase = snapshot.documents.compactMap{
                        document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let age = data["age"] as? Double ?? 0.0
                        let sex = data["sex"] as? String ?? ""
                        let weight = data["weight"] as? Double ?? 0.0
                        let height = data["height"] as? Double ?? 0.0
                        let amr = data["amr"] as? Double ?? 0.0
                        let hip = data["hip"] as? Double ?? 0.0
                        let bai = data["bai"] as? Double ?? 0.0
                        let exerciseLevel = data["exerciseLevel"] as? String ?? ""
                        let bmi = data["bmi"] as? Double ?? 0.0
                        let MaleBMR = data["MaleBMR"] as? Double ?? 0.0
                        let FemaleBMR = data["FemaleBMR"] as? Double ?? 0.0
                        let TDEE = data["TDEE"] as? Double ?? 0.0
                        
                        return User(name: name, age: age, sex: sex, weight: weight, height: height, amr: amr, hip: hip, bai: bai, exerciseLevel: exerciseLevel, id: id)
                        }
                }
                else {
                    print("Snapshot is nil")
                }
            }
        }
        
    }
    
    func deleteUserInformationfromFirestore(user: User){
        //Check authentication of userID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        //Firestore reference
        let db = Firestore.firestore()
        
        //Specify the document to delete
        db.collection("userinformation").document(user.id.uuidString).delete()
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
    var exerciseLevel: String = ""
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
    
    mutating func CalculateAMRwithExerciseLevel() {
        if self.exerciseLevel == "Light 1x week" && self.sex == "M" {
            self.amr = self.MaleBMR * lightExercise
        }
        else if self.exerciseLevel == "Light 1x week" && self.sex == "F" {
            self.amr = self.FemaleBMR * lightExercise
        }
        else if self.exerciseLevel == "Moderate 3x week" && self.sex == "M" {
            self.amr = self.MaleBMR * moderateExercise
        }
        else if self.exerciseLevel == "Moderate 3x week" && self.sex == "F" {
            self.amr = self.FemaleBMR * moderateExercise
        }
        else if self.exerciseLevel == "Heavy 5x week" && self.sex == "M" {
            self.amr = self.MaleBMR * heavyExercise
        }
        else if self.exerciseLevel == "Heavy 5x week" && self.sex == "F" {
            self.amr = self.FemaleBMR * heavyExercise
        }
        else if self.exerciseLevel == "Extra heavy 6-7x week" && self.sex == "M" {
            self.amr = self.MaleBMR * ExtraheavyExercise
        }
        else if self.exerciseLevel == "Extra heavy 6-7x week" && self.sex == "F" {
            self.amr = self.FemaleBMR * ExtraheavyExercise
        }
    }
}
