//
//  listControllerTests.swift
//  fast-phone
//
//  Created by Marek Newton on 2/1/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import XCTest
import UIKit
@testable import fast_phone

class listControllerTests: XCTestCase {
    
    let viewController: ListController = ListController()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTableView() {
        XCTAssert(viewController.tableView.numberOfSections == 1)
        XCTAssert(viewController.tableView.numberOfRows(inSection: 0) ==
            allTrys().count)
    }
    
}
