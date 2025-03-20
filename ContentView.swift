//
//  ContentView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data:Routine
    @EnvironmentObject var  routinetracker: RoutineTracker
    @State var isLoading = true
    var body: some View {
        Group{
            if isLoading {
                VStack {
                    RegistrationView()
                }
            }
            else {
                MenuView()
            }
        }
        .onAppear {
            //Simulate a background task or data loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation{
                    self.isLoading = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
