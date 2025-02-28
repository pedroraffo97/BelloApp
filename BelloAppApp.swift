//
//  BelloAppApp.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import SwiftUI

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BelloAppApp: App {
    //register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var data = Routine()
    @StateObject var routinetracker = RoutineTracker()
    @StateObject var userinformation = UserInformation()
    @StateObject var exerciseglossary = ExerciseGlossary()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(data)
            .environmentObject(routinetracker)
            .environmentObject(userinformation)
            .environmentObject(exerciseglossary)
            .onAppear {
                // when starting load saved routine tracker information
                routinetracker.loadTrainingLogfromFirestore()
                // when starting load saved user information
                userinformation.loadUserInformationtoFirestore()
                //when starting load new_routine from the Firestore Database
                data.loadRoutinetoFirestore()
            }
        }
        //when updating the user ID it will update the Firestore data for the current User
        .onChange(of: AuthenticationManager().userID){_ in
            data.loadRoutinetoFirestore()
            userinformation.loadUserInformationtoFirestore()
            routinetracker.loadTrainingLogfromFirestore()
            
        }
        
        .onChange(of: routinetracker.FinishedTrainings){_ in
            
            for traininglog in routinetracker.FinishedTrainings {
                routinetracker.addTrainingLogtoFirestore(traininglog: traininglog)
            }
            
        }
        // when changed or inputted new user information, saved the data in the documentsDirectory from the FileManager
        .onChange(of:userinformation.UserInformationDataBase){_ in
            for user in userinformation.UserInformationDataBase {
                userinformation.addUserInformationtoFirestore(user: user)
            }
        }
        // when changed or inputted a new routine, saved the data in the documentsDirectory from the FileManager
        .onChange(of:data.new_routine){_ in
        
            for exercise in data.new_routine {
                data.addRoutinetoFirestore(exercise: exercise)
            }
            
        }
    }
}
