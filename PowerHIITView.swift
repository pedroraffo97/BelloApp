//
//  PowerHIITView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 10.12.23.
//

import Foundation

import SwiftUI

struct PowerHIITView: View {
    @EnvironmentObject var data: Routine
    var body: some View {
        ScrollView{
            LazyVStack {
                WarmUpView_2()
                    .padding()
                HIITCoreTraining2View()
                    .padding()
                stretchingView()
                    .padding()
                }
            }
        }
    }
        

        
struct PowerHIITView_Previews: PreviewProvider {
    static var previews: some View {
        PowerHIITView()
                .environmentObject(Routine())
        }
    }
