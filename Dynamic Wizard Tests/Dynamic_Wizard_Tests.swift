//
//  Dynamic_Wizard_Tests.swift
//  Dynamic Wizard Tests
//
//  Created by Warren Milward on 24/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import XCTest
@testable import Dynamic_Wizard

class Dynamic_Wizard_Tests: XCTestCase {

    //
    // Test that the data structures match the JSON for Codable decoding
    //
    func testDecoding() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Snacks", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }

        let wizard = JSONWizard(withContents: data)
        XCTAssertNotNil(wizard)
        XCTAssertEqual(wizard!.screens.count, 7)
        XCTAssertNotNil(wizard!.screens["cone"])
    }

}
