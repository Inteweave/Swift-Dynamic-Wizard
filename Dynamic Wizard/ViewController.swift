//
//  ViewController.swift
//  Dynamic Wizard
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var controller: SnacksWizardController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onStartWizard(_ sender: Any) {
        controller = SnacksWizardController(navigationController: navigationController!)
        controller!.startWizard() {
            self.navigationController?.popToRootViewController(animated: true)
            self.controller = nil
        }

    }
}

