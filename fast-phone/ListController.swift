//
//  ListController.swift
//  fast-phone
//
//  Created by Marek Newton on 1/31/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    var trys: Array<Try> = [Try]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trys = allTrys()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let label: UILabel = cell.viewWithTag(1) as! UILabel
        label.text = "\(trys[indexPath.row].score) \(dateFormatter.string(from: trys[indexPath.row].date as! Date))"
        
        return cell
    }
}

