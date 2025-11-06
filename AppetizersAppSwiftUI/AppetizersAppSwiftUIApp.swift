//
//  AppetizersAppSwiftUIApp.swift
//  AppetizersAppSwiftUI
//
//  Created by Emirhan Ipek on 10.10.2025.
//

import SwiftUI

@main
struct AppetizersApp: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)
        }
    }
}
