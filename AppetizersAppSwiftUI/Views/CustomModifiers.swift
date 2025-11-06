//
//  CustomModifiers.swift
//  AppetizersAppSwiftUI
//
//  Created by Emirhan İpek on 6.11.2025.
//

import SwiftUI

struct StandardButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(Color("brandPrimary"))
            .controlSize(.large)
    }
}

extension View {
    func standardButtonStyle() -> some View {
        self.modifier(StandardButtonStyle())
    }
}
