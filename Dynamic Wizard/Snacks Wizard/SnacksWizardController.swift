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
class SnacksWizardController: DidGoBackDelegate, EventDelegate {
    let wizard: JSONWizard
    let factory: CoordinatorFactory
    var coordinators = [Coordinator]()
    let backButtonEventDetector = BackButtonEventDetector()
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
            factory = CoordinatorFactory(wizard: wizard, navigationController: navigationController)
            backButtonEventDetector.delegate = self
            navigationController.delegate = backButtonEventDetector
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
        factory.delegate = self
        if let coordinator = try? factory.coordinatorForScreen(wizard.currentScreen) {
            coordinators.append(coordinator)
            coordinator.start()
        }
    }

    ///
    /// The user has pressed the back button. This event is not controlled by the wizard.
    /// Tell the wizard that it needs to pop a screen so that its current screen remains correct.
    /// Remove the last coordinator, or complete the wizard if it is the initial screen of the wizard
    ///
    func backButtonPressed() {
        wizard.back()
        if coordinators.count == 1 {
            completion?()
        } else {
            coordinators.removeLast(1)
        }
    }

    ///
    /// Handle an event from a screen
    ///
    /// - parameter event: The event as defined by the screen
    func onEvent(_ event: String) {
        if event == "finish" {
            completion?()
        } else if let screenIdentifier = try? wizard.onEvent(event: event),
            let coordinator = try? factory.coordinatorForScreen(screenIdentifier) {
            coordinators.append(coordinator)
            coordinator.start()
        }
    }

}
