//
//  ResultViewController.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit


///
/// Delegate for the view
///
protocol ResultViewControllerDelegate: AnyObject {
    var label: String { get }
    func finishPressed()
}

///
/// A view controller with a description and a finish button
///
/// Raises the **finish** event
///
class ResultViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    weak var delegate: ResultViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
       label.text = delegate?.label
    }

    @IBAction func onResult(_ sender: Any) {
        delegate?.finishPressed()
    }
}
