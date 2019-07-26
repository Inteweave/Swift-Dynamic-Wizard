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
    let startScreen: String

    ///
    /// Create a wizard from the contents of a JSON file.
    ///
    /// - parameter withContents: The Data from the JSON file
    /// - returns: the created wizard or nil on error
    ///
    init?(withContents contents: Data) {
        let decoder = JSONDecoder()
        if let definition = try? decoder.decode(WizardModel.self, from: contents) {
            var navigation = [Navigation]()
            for nav in definition.navigation {
                navigation.append(Navigation(onScreen: nav.onScreen,
                                             when: nav.when,
                                             navigateTo: nav.navigateTo))
            }

            var screenDict = [String: ScreenDefinition]()
            for screenDefinition in definition.screens {
                if let screenId = screenDefinition["id"] {
                    screenDict[screenId] = screenDefinition
                }
            }
            self.screens = screenDict
            self.startScreen = definition.start

            super.init(screenNavigations: navigation)
        } else {
            return nil
        }
    }

}
