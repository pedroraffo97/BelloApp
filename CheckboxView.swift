//
//  CheckboxView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 12.12.23.
//

import Foundation

import SwiftUI


struct CheckboxView:View {
    @State private var isChecked: Bool = false
    var body: some View {
        Toggle("", isOn: $isChecked)
            .toggleStyle(.switch)
            .fixedSize()
            }
        }

struct TrialCheckboxView: View {
    var body: some View {
        VStack{
            HStack{
                Text("exercise 1")
                CheckboxView()
            }
            HStack{
                Text("exercise 2")
                CheckboxView()
            }
        }
    }
}

struct CheckboxView_preview: PreviewProvider {
    static var previews: some View {
        TrialCheckboxView()
    }
}
