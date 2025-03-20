//
//  Modifiers.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 19.03.25.
//

import Foundation
import SwiftUI

struct BlackBackgroundmodifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

extension View {
    public func blackBackground() -> some View {
        self.modifier(BlackBackgroundmodifier())
    }
}
