//
//  ResultViewModel.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Coordinator for the **ResultViewController**
///
class ResultViewModel {
    let screen: String
    let screenContents: [String: String]
    weak var eventDelegate: EventDelegate?

    ///
    /// Returns a newly created model initialised for the specified screen
    ///
    /// - parameter navigationController: The navigation controller that will display the screen
    /// - parameter screen: The *ScreenName* of the screen to display
    /// - returns: The newly created model
    ///
    init(screen: String, contents: [String: String]) {
        self.screen = screen
        screenContents = contents
    }
}

// MARK: - TwoButtonViewControllerDelegate

extension ResultViewModel {
    var label: String {
        return screenContents["description"] ?? "Not defined in JSON"
    }

    ///
    /// This screen raises the event **finish** when the user presses the button defined as button 1
    ///
    func finishPressed() {
        eventDelegate?.event("finish", wasRaisedOnScreen: screen)
    }
}
