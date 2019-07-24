//
//  EventCoordinator.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

protocol EventCoordinator: Coordinator {
    var eventDelegate: EventDelegate? { get set }
}
