//
//  homeControllerTests.swift
//  fast-phone
//
//  Created by Marek Newton on 1/31/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import XCTest
import UIKit
@testable import fast_phone
import CoreData

class homeControllerTests: XCTestCase {
    
    let viewController: HomeController = HomeController()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUserHighScore() {
        var data: Array<Try> = []
        let context: NSManagedObjectContext = getContext()
        
        for i in 1...5 {
            
            let Try: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Try", in: context)!
            let newTry: NSManagedObject = NSManagedObject(entity: Try, insertInto: context)
            
            newTry.setValue(Float(i), forKey: "score")
            newTry.setValue(Date(), forKey: "date")
            
            data.append(newTry as! Try)
        }
        
        XCTAssert(data.count > 1)
        XCTAssert(viewController.getUserHighScore(array: data) == String(Float(5)))
    }
    
    func testGetJSON() {
        
    }
}
