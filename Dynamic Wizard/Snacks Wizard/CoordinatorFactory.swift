//
//  CoordinatorFactory.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

class CoordinatorFactory {
    private let wizard: JSONWizard
    private let navigationController: UINavigationController
    weak var delegate: EventDelegate?
    
    init(wizard: JSONWizard, navigationController: UINavigationController) {
        self.wizard = wizard
        self.navigationController = navigationController
    }

    func coordinatorForScreen(_ screenIdentifier: String) throws -> EventCoordinator {
        if let contents = wizard.screens[screenIdentifier] {
            if let templateName = contents["template"] {
                let coordinator = try coordinatorForTemplate(templateName, screenIdentifier: screenIdentifier, screenContents: contents)
                coordinator.eventDelegate = delegate
                return coordinator
            } else {
                throw WizardError.definitionError("No template found in JSON", screen: screenIdentifier)
            }
        } else {
            throw WizardError.definitionError("No definition found in JSON", screen: screenIdentifier)
        }
    }

    private func coordinatorForTemplate(_ templateName: String, screenIdentifier: String, screenContents: [String: String]) throws -> EventCoordinator {
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


