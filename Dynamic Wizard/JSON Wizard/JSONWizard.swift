//
//  JSONWizard.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

typealias Navigation = ScreenNavigation<String, String>
typealias ScreenDefinition = [String: String]

///
/// Wizard class to parse the JSON file.
/// It creates the wizard definition and contains the screen contents
///
class JSONWizard: Wizard<String, String> {
    let screens: [String: ScreenDefinition]

    ///
    /// The contents of the JSON file
    ///
    private struct WizardContents: Codable {
        let start: String
        let screens: [[String: String]]
        let navigation: [Navigation]
        struct Navigation: Codable {
            let on: String
            let when: String
            let to: String
        }
    }

    ///
    /// Create a wizard from the contents of a JSON file.
    ///
    /// - parameter withContents: The Data from the JSON file
    /// - returns: the created wizard or nil on error
    ///
    init?(withContents contents: Data) {
        let decoder = JSONDecoder()
        if let definition = try? decoder.decode(WizardContents.self, from: contents) {
            var navigation = [Navigation]()
            for nav in definition.navigation {
                navigation.append(Navigation(from: nav.on, event: nav.when, to: nav.to))
            }

            var screenDict = [String: ScreenDefinition]()
            for screenDefinition in definition.screens {
                if let id = screenDefinition["id"] {
                    screenDict[id] = screenDefinition
                }
            }
            self.screens = screenDict

            super.init(screenNavigations: navigation, startScreen: definition.start)
        } else {
            return nil
        }
    }

}
