//
//  WizardModel.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 26/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

///
/// The contents of the JSON file
///
struct WizardModel: Codable {
    let start: String
    let screens: [[String: String]]
    let navigation: [Navigation]
    struct Navigation: Codable {
        let onScreen: String
        let when: String
        let navigateTo: String
    }
}
