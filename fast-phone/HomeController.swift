//
//  ViewController.swift
//  fast-phone
//
//  Created by Marek Newton on 1/30/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation

class HomeController: UIViewController {
    
    @IBOutlet var newTryButton: UIButton!
    @IBOutlet var everyoneRecordLabel: UILabel!
    @IBOutlet var userRecoredLabel: UILabel!
    
    let urlString: String = "http://localhost:5000"

    override func viewDidLoad() {
        super.viewDidLoad()
        newTryButton.layer.cornerRadius = 9
        //let json: NSData = getJSON(urlToRequest: urlString)
        //let everyoneData: NSArray = parseJSON(inputData: json)
        //print(getEveryoneHighScore(array: data))
        
        let userData: Array<Try> = allTrys()
        userRecoredLabel.text = getUserHighScore(array: userData)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkGyro()
    }
    
    /*func getEveryoneHighScore(array: NSArray) -> String {
        var highScore: Any = 0
        
        for a in array {
            let dictionary: Dictionary<String, Any> = a as! Dictionary<String, Any>
            
            if dictionary["score"] > highScore {
                highScore = dictionary["score"] as! Float
            }
        }
    
        return String(describing: highScore)
    }*/
    
    func getUserHighScore(array: Array<Try>) -> String {
        var highScore: Float = Float(0)
        
        for a in array {
            if a.score > highScore {
                highScore = a.score
            }
        }
        
        return String(highScore)
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return try! NSData(contentsOf: NSURL(string: urlToRequest) as! URL)
    }
    
    func parseJSON(inputData: NSData) -> NSArray{
        let boardsDictionary = try! JSONSerialization.jsonObject(with: inputData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        
        return boardsDictionary
    }
    
    func checkGyro() {
        let manageer: CMMotionManager = CMMotionManager()
        if !manageer.isGyroAvailable {
            let alert: UIAlertController = UIAlertController(title: "Darn it", message:
                "your gyro dosen't work. this app is useless",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func newTryButtonOnClick(_ sender: Any) {
        let vc: TryController = self.storyboard?.instantiateViewController(withIdentifier: "try") as! TryController
        self.present(vc, animated: true, completion: nil)
    }
}

