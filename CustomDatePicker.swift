//
//  CustomDatePicker.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 31.03.25.
//

import SwiftUI

struct CustomDatePicker: UIViewRepresentable {
    @Binding var date: Date

    func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.tintColor = .white
        picker.overrideUserInterfaceStyle = .dark // ✅ Force dark appearance
        picker.addTarget(context.coordinator, action: #selector(Coordinator.updateDate(sender:)), for: .valueChanged)
        return picker
    }

    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = date
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(date: $date)
    }

    class Coordinator: NSObject {
        var date: Binding<Date>

        init(date: Binding<Date>) {
            self.date = date
        }

        @objc func updateDate(sender: UIDatePicker) {
            self.date.wrappedValue = sender.date
        }
    }
}
