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
    @IBOutlet var yLabel: UILabel!
    @IBOutlet var zLabel: UILabel!
    
    var timer: Timer = Timer()
    var counter: Int = 10
    var tryGoing: Bool = false
    
    var motionManager: CMMotionManager!
    var highScore: Double = Double(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownLabel?.text = "10"
        countDown()
        
        xLabel?.text = "0.0"
        yLabel?.text = "0.0"
        zLabel?.text = "0.0"
    }
    
    func startMotion() {
        motionManager = CMMotionManager()
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates()
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!,
                                                    withHandler:{ data,
                                                        error in
                
                let checks: Array<Double> = [(data?.acceleration.x)!,
                                             (data?.acceleration.y)!,
                                             (data?.acceleration.z)!]
                
                self.xLabel.text = String(Float((data?.acceleration.x)!))
                self.yLabel.text = String(Float((data?.acceleration.y)!))
                self.zLabel.text = String(Float((data?.acceleration.z)!))
                
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:
            #selector(self.update), userInfo: nil, repeats: true)
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
        motionManager?.stopAccelerometerUpdates()
        var betterHighScore: Float = Float()
        
        if(highScore < 0) {
            betterHighScore = Float(-highScore)
        } else {
            betterHighScore = Float(highScore)
        }
        
        
        let alert: UIAlertController = UIAlertController(title:
            "\(String(betterHighScore))", message: "save or try again?",
                                preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Save",
                                      style: UIAlertActionStyle.default,
                                      handler: { action in
            self.save() }))
        alert.addAction(UIAlertAction(title: "Again",
                                      style: UIAlertActionStyle.default,
                                      handler: {action in
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
        postTry(score: String(highScore), date: String(describing: Date()),
                                                url: "http://localhost:5000")
        
        let vc: HomeController =
            self.storyboard?.instantiateViewController(withIdentifier: "home")
                as! HomeController
        self.present(vc, animated: true, completion: nil)
    }
    
    func postTry(score: String, date: String, url: String) {
        let data: [String: String] = ["score": score, "date": date]
        let json: Data = try! JSONSerialization.data(withJSONObject: data)
        
        let url: URL = URL(string: url)!
        var request: URLRequest = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = json
        
        let task: URLSessionDataTask =
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data,
                                                                 options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
    }

}
