//
//  dataControllerTests.swift
//  fast-phone
//
//  Created by Marek Newton on 2/1/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import XCTest
import CoreData
@testable import fast_phone

class dataControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func testAllTrys() {
        let trys: Array<Try> = allTrys()
        XCTAssert(trys.count > 0)
    }
    
    func testAddTry() {
        let startTrys: Int = allTrys().count
        addTry(score: 1.23, date: Date())
        let endTrys: Int = allTrys().count
        XCTAssert(startTrys != endTrys)
    }
}
