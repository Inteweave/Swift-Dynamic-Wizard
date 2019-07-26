//
//  TwoButtonViewController.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// A template view controller with a title and 2 buttons
///
/// Raises the **button1** or **button2** event
///
class TwoButtonViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    var viewModel: TwoButtonViewModel?

    ///
    /// Initialise ourselves creating the view model
    ///
    /// - parameter screen: the screen identifier
    /// - parameter contents: the screen contents for the view model
    /// - parameter eventDelegate: The delegate to call when events are to be raised
    ///
    init(screen: String, contents: [String: String], eventDelegate: EventDelegate?) {
        super.init(nibName: nil, bundle: nil)
        viewModel = TwoButtonViewModel(screen: screen, contents: contents)
        viewModel!.eventDelegate = eventDelegate
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    ///
    /// Set the contents from the view model
    ///
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = viewModel?.label
        button1.setTitle(viewModel?.button1Title, for: .normal)
        button2.setTitle(viewModel?.button2Title, for: .normal)
    }

    @IBAction func button1Pressed(_ sender: Any) {
        viewModel?.button1Pressed()
    }

    @IBAction func button2Pressed(_ sender: Any) {
        viewModel?.button2Pressed()
    }

}
