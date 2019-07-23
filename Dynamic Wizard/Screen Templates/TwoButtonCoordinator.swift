//
//  TwoButtonCoordinator.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

protocol EventDelegate: AnyObject {
    ///
    /// Raise the user event
    ///
    func onEvent(_ event: String)
}

class TwoButtonCoordinator: Coordinator {

    let navigationController: UINavigationController
    let screenContents: [String: String]
    weak var eventDelegate: EventDelegate?

    ///
    /// Returns a newly created coordinator initialised for the specified screen
    ///
    /// - parameter navigationController: The navigation controller that will display the screen
    /// - parameter screen: The *ScreenName* of the screen to display
    /// - returns: The newly created coordinator
    ///
    init(navigationController: UINavigationController, screen: [String: String]) {
        self.navigationController = navigationController
        screenContents = screen
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