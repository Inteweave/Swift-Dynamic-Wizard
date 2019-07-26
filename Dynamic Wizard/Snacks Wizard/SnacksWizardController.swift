//
//  SnacksWizardController.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Controller for the snacks wizard
/// Provides the wizard definition from a local JSON file
///
class SnacksWizardController: EventDelegate {
    let wizard: JSONWizard
    let factory: ViewFactory
    let navigationController: UINavigationController
    var completion: (() -> Void)?

    ///
    /// Failable initialization
    ///
    /// - parameter navigationController: The navigation controller
    ///
    init?(navigationController: UINavigationController) {
        if let url = Bundle.main.url(forResource: "Snacks", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let wizard = JSONWizard(withContents: data) {
            self.wizard = wizard
            self.navigationController = navigationController
            factory = ViewFactory(wizard: wizard)
            factory.eventDelegate = self
        } else {
            return nil
        }
    }

    ///
    /// Start the wizard
    ///
    /// - parameter completion: Completion block to be invoked when the wizard finishes or is cancelled.
    ///
    func startWizard(completion: @escaping () -> Void) {
        self.completion = completion
        if let viewController = try? factory.viewControllerForScreen(wizard.startScreen) {
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    ///
    /// Handle an event from a screen
    ///
    /// - parameter event: The event as defined by the screen
    ///
    func event(_ event: String, wasRaisedOnScreen screen: String) {
        if event == "finish" {
            completion?()
        } else if let screenIdentifier = try? wizard.event(event: event, wasRaisedOnScreen: screen),
            let viewController = try? factory.viewControllerForScreen(screenIdentifier) {
            navigationController.pushViewController(viewController, animated: true)
        }
    }

}
