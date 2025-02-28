//
//  RoutineTrackerClass.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

import Firebase

import FirebaseFirestore

import FirebaseAuth

class RoutineTracker: ObservableObject {
    @Published var FinishedTrainings: [TrainingLog] = [
        TrainingLog(name: "", day: "", kcal: "", exercises: "", group: [""])
    ]
    
    //function to add FinishedTrainings to Firestore
    func addTrainingLogtoFirestore(traininglog: TrainingLog) {
        //authentication check
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        //reference to Firestore
        let db = Firestore.firestore()
        
        let TraininglogValues: [String: Any] = [
            "id": traininglog.id.uuidString,
            "name": traininglog.name,
            "day": traininglog.day,
            "kcal": traininglog.kcal,
            "exercises": traininglog.exercises,
            "group": traininglog.group
        ]
        
        //add data to the Firestore database
        db.collection("users").document(userID).collection("finishedTrainings").document(traininglog.id.uuidString).setData(TraininglogValues, merge: true)
    }
    
    //function to load Finished Trainings from Firestore
    func loadTrainingLogfromFirestore(){
        //Check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        //reference to Firestore
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("finishedTrainings").getDocuments{
            snapshot, error in
            //check if there is any errors
            if let error = error {
                print("Error getting documents \(error)")
            }
            else {
                if let snapshot = snapshot {
                    //retrieve data from collection
                    self.FinishedTrainings = snapshot.documents.compactMap{
                        document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let day = data["day"] as?  String ?? ""
                        let kcal = data["kcal"] as? String ?? ""
                        let exercises = data["exercises"] as? String ?? ""
                        let group = data["group"] as? [String] ?? [""]
                        
                        return TrainingLog(name: name, day: day, kcal: kcal, exercises: exercises, group: group, id: id)
                    }
                    
                }
                else {
                    print("Snapshot is nil")
                }
            }
            
        }
    }
    
    //function to delete Finished Trainings from Firestore
    func deleteTrainingLogfromFirestore(traininglog: TrainingLog){
        //Check Authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        //reference
        let db = Firestore.firestore()
        
        //delete documents from Firestore
        db.collection("users").document(userID).collection("finishedTrainings").document(traininglog.id.uuidString).delete()
    }
    
   
}

struct TrainingLog : Identifiable, Encodable, Decodable, Equatable {
    var name: String
    var day: String
    var kcal: String
    var exercises: String
    var group: [String]
    var id = UUID()
}
