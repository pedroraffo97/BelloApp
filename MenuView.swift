//
//  MenuView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct MenuView: View {
    var body: some View {
        TabView{
                UserProfileView()
                .tabItem {
                        Image(systemName:"person.circle")
                        Text("Profile")
                    }
                UserInformationView()
                    .tabItem {
                        Image(systemName:"person.badge.plus")
                        Text("New User")
                    }
            
                ExerciseGlossaryView()
                        .tabItem {
                            Image(systemName: "figure.run.square.stack.fill")
                            Text("Glossary")
                }
                TrainingsView()
                        .tabItem {
                            Image(systemName: "figure.run")
                            Text("Trainings")
                        }
                ToolsView()
                        .tabItem {
                            Image(systemName: "wrench.and.screwdriver")
                            Text("Tools")
                        }
                }
        }
    }

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(UserInformation())
            .environmentObject(ExerciseGlossary())
            .environmentObject(RoutineTracker())
    }
}
