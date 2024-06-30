//
//  RoutineTrackerClass.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

class RoutineTracker: ObservableObject {
    @Published var FinishedTrainings: [TrainingLog] = [
        TrainingLog(name: "", day: "", kcal: "", exercises: "", group: [""])
    ]
    //Save the training data to a file:
    func save(){
        do {
            let fileURL = try getTrainingsFileURL()
            let data = try JSONEncoder().encode(FinishedTrainings)
            try data.write(to: fileURL)
            print("Trainings saved")
        }
        catch {
            print("Unable to print \(error)")
        }
    }
    //Load the training data to a file:
    func load() {
            do {
                let fileURL = try getTrainingsFileURL()
                let data = try Data(contentsOf: fileURL)
                FinishedTrainings = try JSONDecoder().decode([TrainingLog].self, from: data)
                print("Trainings loaded: \(FinishedTrainings.count)")
            } catch {
                print("Unable to load trainings: \(error)")
            }
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

// FileManager Location to save the data
private func getTrainingsFileURL() throws -> URL{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("FinishedTrainings.json")
}
