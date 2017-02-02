//
//  tryControllerTests.swift
//  fast-phone
//
//  Created by Marek Newton on 2/1/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import XCTest
import UIKit
import CoreMotion
@testable import fast_phone

class tryControllerTests: XCTestCase {
    
    let viewController: TryController = TryController()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testStartMotion() {
        viewController.startMotion()
    }
    
    func testCountDown() {
        viewController.countDown()

        XCTAssert(viewController.tryGoing == true)
        XCTAssert(viewController.timer != Timer())
    }
    
    func testUdate() {
        viewController.update()
        
        XCTAssert(viewController.counter == viewController.counter - 1)
        XCTAssert(viewController.countDownLabel.text ==
            String(viewController.counter))
    }
    
    func testEnd() {
        viewController.end()
        
        XCTAssert(viewController.timer.isValid == false)
        XCTAssert(viewController.tryGoing == false)
        XCTAssert(viewController.motionManager.isAccelerometerActive == false)
        XCTAssert(viewController.presentedViewController is UIAlertController)
    }
}
