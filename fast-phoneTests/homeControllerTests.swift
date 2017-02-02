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
import Foundation

class homeControllerTests: XCTestCase {
    
    let viewController: HomeController = HomeController()
    let data1: NSArray = NSArray()
    var json1: NSData = NSData()
    var json2: NSData = NSData()
    
    
    override func setUp() {
        json1 = viewController.getJSON(urlToRequest:
            "http://localhost:5000/test1")
        json2 = viewController.getJSON(urlToRequest:
            "http://localhost:5000/test2")

        
        super.setUp()
    }
    
    func testGetUserHighScore() {
        var data: Array<Try> = []
        let context: NSManagedObjectContext = getContext()
        
        for i in 1...5 {
            
            let Try: NSEntityDescription =
                NSEntityDescription.entity(forEntityName: "Try", in: context)!
            let newTry: NSManagedObject =
                NSManagedObject(entity: Try, insertInto: context)
            
            newTry.setValue(Float(i), forKey: "score")
            newTry.setValue(Date(), forKey: "date")
            
            data.append(newTry as! Try)
        }
        
        XCTAssert(data.count > 1)
        XCTAssert(viewController.getUserHighScore(array: data) == String(
            Float(5)))
    }
    
    func testGetEveryoneHighScore() {
        let data1: NSArray = ([
            ["data": "some day", "score": "1.342" ],
            ["date": "a day", "score": "1.32432"],
            ["date": "what", "score": "2.0423"]
        ])
        
        XCTAssert(viewController.getEveryoneHighScore(array: data1) == "2.0423")
        
        let data2: NSArray = ([
            ["data": "some day", "score": "10.3425234523524352" ],
            ["date": "a day", "score": "1.9789782"],
            ["date": "a day", "score": "1.9797987"],
            ["date": "a day", "score": "1.90890"]
        ])
        
        XCTAssert(viewController.getEveryoneHighScore(
            array: data2) == String(Float(10.3425234523524352))
        )
    }
    
    func testGetJSON() {
        XCTAssert(json1.length == 26)
        XCTAssert(json2.length > 0)
    }
    
    func testParseJSON() {
        let parsedJson1: NSArray = viewController.parseJSON(inputData: json1)
        let parsedJson2: NSArray = viewController.parseJSON(inputData: json2)
        
        XCTAssert(parsedJson1.count > 0)
        XCTAssert(parsedJson2.count > 0)
        
        XCTAssert(Int(String(describing: parsedJson1[0])) == 1)
        XCTAssert(Int(String(describing: parsedJson1[1])) == 2)
        XCTAssert(Int(String(describing: parsedJson1[2])) == 3)
        XCTAssert(Int(String(describing: parsedJson1[3])) == 4)
    
        XCTAssert(String(describing: parsedJson2[0]) == "panda")
        XCTAssert(String(describing: parsedJson2[1]) == "bro")
        XCTAssert(String(describing: parsedJson2[2]) == "panda")
    }

}
