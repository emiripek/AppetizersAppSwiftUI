//
//  User.swift
//  AppetizersAppSwiftUI
//
//  Created by Emirhan İpek on 6.11.2025.
//

import Foundation

struct User: Codable {
    var firstName       = ""
    var lastName        = ""
    var email           = ""
    var birthdate       = Date()
    var extraNapkins    = false
    var frequentRefills = false
}
