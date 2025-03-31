//
//  CustomNumberField.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 31.03.25.
//

import SwiftUI

struct CustomNumberField: UIViewRepresentable {
    @Binding var value: Float

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.textColor = .white

        // ✅ Caja negra con borde blanco
        textField.backgroundColor = UIColor.black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 8

        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textAlignment = .left

        // ✅ Padding izquierdo
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged), for: .editingChanged)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = value == 0 ? "" : String(format: "%.0f", value)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject {
        var value: Binding<Float>

        init(value: Binding<Float>) {
            self.value = value
        }

        @objc func valueChanged(_ sender: UITextField) {
            if let text = sender.text, let number = Float(text) {
                value.wrappedValue = number
            } else {
                value.wrappedValue = 0
            }
        }
    }
}
