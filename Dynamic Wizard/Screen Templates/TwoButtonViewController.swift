//
//  TwoButtonViewController.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

///
/// Delegate for the view
///
protocol TwoButtonViewControllerDelegate: AnyObject {
    var label: String { get }
    var button1Title: String { get }
    var button2Title: String { get }

    func button1Pressed()
    func button2Pressed()
}

///
/// A template view controller with a title and 2 buttons
///
class TwoButtonViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    weak var delegate: TwoButtonViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = delegate?.label
        button1.setTitle(delegate?.button1Title, for: .normal)
        button2.setTitle(delegate?.button2Title, for: .normal)
    }

    @IBAction func button1Pressed(_ sender: Any) {
        delegate?.button1Pressed()
    }

    @IBAction func button2Pressed(_ sender: Any) {
        delegate?.button2Pressed()
    }

}
