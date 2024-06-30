//
//  SignUpView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct ApplicationEntryView: View {
    @State var name = ""
    @State var number = ""
    @State var email = ""
    @State var age = ""
    @State var isOn = false
    
    var body: some View {
            VStack {
                Text("Information Input:")
                UserInformationView()
                    .padding(20)
                NavigationStack{
                    NavigationLink("Start"){
                        MenuView()
                    }
                }
                .padding(20)
            }
        }
    }

struct Application_EntryView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationEntryView()
    }
}
