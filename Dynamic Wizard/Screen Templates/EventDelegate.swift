//
//  EventDelegate.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

protocol EventDelegate: AnyObject {
    ///
    /// Raise the user event
    ///
    func onEvent(_ event: String)
}
