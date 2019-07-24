//
//  TwoButtonCoordinator.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Coordinator for the 2 button template screen
///
class TwoButtonCoordinator: EventCoordinator {
    let navigationController: UINavigationController
    let screenContents: [String: String]
    weak var delegate: EventDelegate?
    var eventDelegate: EventDelegate? {
        get {
            return delegate
        }
        set {
            delegate = newValue
        }
    }

    ///
    /// Returns a newly created coordinator initialised for the specified screen
    ///
    /// - parameter navigationController: The navigation controller that will display the screen
    /// - parameter screen: The *ScreenName* of the screen to display
    /// - returns: The newly created coordinator
    ///
    init(navigationController: UINavigationController, contents: [String: String]) {
        self.navigationController = navigationController
        screenContents = contents
    }
    
    ///
    /// Display the view controller
    ///
    func start() {
        let viewController = TwoButtonViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - TwoButtonViewControllerDelegate

extension TwoButtonCoordinator: TwoButtonViewControllerDelegate {
    var label: String {
        return screenContents["description"] ?? "Not defined in JSON"
    }

    var button1Title: String {
        return screenContents["button1"] ?? "Not defined in JSON"
    }

    var button2Title: String {
        return screenContents["button2"] ?? "Not defined in JSON"
    }

    ///
    /// This screen raises the event **button1** when the user presses the button defined as button 1
    ///
    func button1Pressed() {
        eventDelegate?.onEvent("button1")
    }

    ///
    /// This screen raises the event **button2** when the user presses the button defined as button 1
    ///
    func button2Pressed() {
        eventDelegate?.onEvent("button2")
    }
}
