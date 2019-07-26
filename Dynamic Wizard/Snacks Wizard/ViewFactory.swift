//
//  ViewFactory.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Class to create a view controller for a template screen given the screen name (a string from the JSON)
///
class ViewFactory {
    private let wizard: JSONWizard
    weak var eventDelegate: EventDelegate?

    ///
    /// Create the factory
    ///
    /// - parameter wizard: The JSON wizard containing the screen definitions
    ///
    init(wizard: JSONWizard) {
        self.wizard = wizard
    }

    ///
    /// Create a view controller for the screen
    ///
    /// - parameter screenIdentifier: The screen we want
    /// - returns: The view controller
    /// - throws: A *WizardError*
    ///
    func viewControllerForScreen(_ screenIdentifier: String) throws -> UIViewController {
        if let contents = wizard.screens[screenIdentifier] {
            if let templateName = contents["template"] {
                return try viewControllerForTemplate(templateName,
                                                     screenIdentifier: screenIdentifier,
                                                     screenContents: contents)

            } else {
                throw WizardError.definitionError("No template found in JSON", screen: screenIdentifier)
            }
        } else {
            throw WizardError.definitionError("No definition found in JSON", screen: screenIdentifier)
        }
    }

    ///
    /// Create a view controller give the template name:
    ///
    /// - parameter templateName: The template for the screen
    /// - parameter screenIdentifier: The name of the screen
    /// - parameter screenContents: The template-specific contents for the screen
    /// - returns: The view controller
    /// - throws: A *WizardError*
    ///
    private func viewControllerForTemplate(_ templateName: String,
                                           screenIdentifier: String,
                                           screenContents: [String: String]) throws -> UIViewController {
        switch templateName {
        case "two-button":
            return TwoButtonViewController(screen: screenIdentifier,
                                           contents: screenContents,
                                           eventDelegate: eventDelegate)

        case "result":
            return ResultViewController(screen: screenIdentifier,
                                        contents: screenContents,
                                        eventDelegate: eventDelegate)

        default:
            throw WizardError.definitionError("No template found in JSON", screen: screenIdentifier)
        }
    }
}
