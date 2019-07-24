//
//  CoordinatorFactory.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Class to create a coordinator for a template screen given the screen name (a string from the JSON)
///
class CoordinatorFactory {
    private let wizard: JSONWizard
    private let navigationController: UINavigationController
    weak var delegate: EventDelegate?

    ///
    /// Create the factory
    ///
    /// - parameter wizard: The JSON wizard containing the screen definitions
    /// - parameter navigationController: The navigation controller the coordinator pushes to
    ///
    init(wizard: JSONWizard, navigationController: UINavigationController) {
        self.wizard = wizard
        self.navigationController = navigationController
    }

    ///
    /// Create a coordinator for the screen
    /// - parameter screenIdentifier: The screen we want
    /// - returns: The coordinator
    /// - throws: A *WizardError*
    ///
    func coordinatorForScreen(_ screenIdentifier: String) throws -> Coordinator {
        if let contents = wizard.screens[screenIdentifier] {
            if let templateName = contents["template"] {
                let coordinator = try coordinatorForTemplate(templateName,
                                                             screenIdentifier: screenIdentifier,
                                                             screenContents: contents)
                coordinator.eventDelegate = delegate
                return coordinator
            } else {
                throw WizardError.definitionError("No template found in JSON", screen: screenIdentifier)
            }
        } else {
            throw WizardError.definitionError("No definition found in JSON", screen: screenIdentifier)
        }
    }

    ///
    /// Create a coordinator give the template name:
    /// - parameter templateName: The template for the screen
    /// - parameter screenIdentifier: The name of the screen
    /// - parameter screenContents: The template-specific contents for the screen
    /// - returns: The coordinator
    /// - throws: A *WizardError*
    ///
    private func coordinatorForTemplate(_ templateName: String,
                                        screenIdentifier: String,
                                        screenContents: [String: String]) throws -> EventCoordinator {
        switch templateName {
        case "two-button":
            return TwoButtonCoordinator(navigationController: navigationController, contents: screenContents)
        case "result":
            return ResultCoordinator(navigationController: navigationController, contents: screenContents)
        default:
            throw WizardError.definitionError("No template found in JSON", screen: screenIdentifier)
        }
    }
}
