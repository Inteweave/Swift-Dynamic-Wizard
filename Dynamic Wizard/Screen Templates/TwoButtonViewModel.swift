//
//  TwoButtonViewModel.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Coordinator for the 2 button template screen
///
class TwoButtonViewModel {
    let screenContents: [String: String]
    let screen: String
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

// MARK: - Screen content

extension TwoButtonViewModel {
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
        eventDelegate?.event("button1", wasRaisedOnScreen: screen)
    }

    ///
    /// This screen raises the event **button2** when the user presses the button defined as button 1
    ///
    func button2Pressed() {
        eventDelegate?.event("button2", wasRaisedOnScreen: screen)
    }
}
