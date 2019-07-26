//
//  ResultViewController.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// A view controller with a description and a finish button
///
/// Raises the **finish** event
///
class ResultViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var viewModel: ResultViewModel?

    ///
    /// Initialise ourselves creating the view model
    ///
    /// - parameter screen: the screen identifier
    /// - parameter contents: the screen contents for the view model
    /// - parameter eventDelegate: The delegate to call when events are to be raised
    ///
    init(screen: String, contents: [String: String], eventDelegate: EventDelegate?) {
        viewModel = ResultViewModel(screen: screen, contents: contents)
        viewModel!.eventDelegate = eventDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = viewModel?.label
    }

    @IBAction func onResult(_ sender: Any) {
        viewModel?.finishPressed()
    }
}
