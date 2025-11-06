//
//  APButton.swift
//  AppetizersAppSwiftUI
//
//  Created by Emirhan İpek on 6.11.2025.
//

import SwiftUI

struct APButton: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(.white)
            .backgroundStyle(Color("brandPrimary"))
            .cornerRadius(10)
    }
}

#Preview {
    APButton(title: "Test Title")
}
