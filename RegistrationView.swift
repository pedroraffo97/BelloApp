//
//  RegistrationView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

struct RegistrationView: View  {
    var body: some View {
        ZStack{
            Image("backgroundGymBW")
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 150, height: 900, alignment: .center)
                .scaledToFit()
                .mask(Rectangle())
            VStack{
                ZStack{
                    VStack {
                        Image("Bello.")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                }
                .padding()
                
            }
        }
    }
    }

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
