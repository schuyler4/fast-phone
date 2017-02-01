//
//  TryController.swift
//  fast-phone
//
//  Created by Marek Newton on 1/30/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import UIKit
import CoreMotion

class TryController: UIViewController {

    @IBOutlet var countDownLabel: UILabel!
    @IBOutlet var xLabel: UILabel!
    
    
    var timer: Timer = Timer()
    var counter: Int = 10
    var tryGoing: Bool = false
    
    var motionManager: CMMotionManager!
    var highScore: Double = Double(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownLabel.text = "10"
        countDown()
    }
    
    func startMotion() {
        motionManager = CMMotionManager()
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates()
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler:{
                data, error in
                
                let checks: Array<Double> = [(data?.acceleration.x)!, (data?.acceleration.y)!, (data?.acceleration.z)!]
                
                for check in checks {
                    if check > self.highScore || check < self.highScore {
                        self.highScore = check
                        print("beat")
                    }
                }
            })
        }
    }
    
    func countDown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update),
                                     userInfo: nil, repeats: true)
        tryGoing = true
        startMotion()
    }
    
    func update() {
        counter -= 1
        countDownLabel.text = String(counter)
        
        if(counter == 0) {
            self.end()
        }
    
    }
    
    func end() {
        timer.invalidate()
        tryGoing = false
        motionManager.stopAccelerometerUpdates()
        var betterHighScore: Float = Float()
        
        if(highScore < 0) {
            betterHighScore = Float(-highScore)
        } else {
            betterHighScore = Float(highScore)
        }
        
        
        let alert: UIAlertController = UIAlertController(title: "\(String(betterHighScore))", message: "save or try again?",preferredStyle:
            UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { action in
            self.save() }))
        alert.addAction(UIAlertAction(title: "Again", style: UIAlertActionStyle.default, handler: {action in
            self.again()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func again() {
        counter = 10
        tryGoing = false
        countDownLabel.text = "10"
        highScore = 0
    
        self.countDown()
    }
        
    func save() {
        addTry(score: Float(highScore), date: Date())
        
        let vc: HomeController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeController
        self.present(vc, animated: true, completion: nil)
    }

}
