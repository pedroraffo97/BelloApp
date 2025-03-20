//
//  MenuView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct MenuView: View {
    
    //MARK: Ensures that the tabview is set to black and the title and icons gray and white depending on selection.
    init () {
        let appareance = UITabBarAppearance()
        appareance.configureWithOpaqueBackground()
        appareance.backgroundColor = UIColor.black
        appareance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appareance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appareance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appareance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        UITabBar.appearance().standardAppearance = appareance
        UITabBar.appearance().scrollEdgeAppearance = appareance
    }
    
    var body: some View {
        TabView{
                UserProfileView()
                .tabItem {
                            Image(systemName:"person.circle")
                            Text("Profile")
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
