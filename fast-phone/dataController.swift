//
//  dataController.swift
//  fast-phone
//
//  Created by Marek Newton on 1/31/17.
//  Copyright © 2017 Marek Newton. All rights reserved.
//

import CoreData
import UIKit

public func getContext() -> NSManagedObjectContext {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}

public func addTry(score: Float, date: Date) {
    let context: NSManagedObjectContext = getContext()
    
    let Try: NSEntityDescription =
        NSEntityDescription.entity(forEntityName: "Try", in: context)!
    let newTry: NSManagedObject =
            NSManagedObject(entity: Try, insertInto: context)
    
    newTry.setValue(score, forKey: "score")
    newTry.setValue(date, forKey: "date")
    
    do {
        try context.save()
    } catch let error as NSError {
        print("could not save study \(error)")
    }
}

public func allTrys() -> Array<Try> {
    guard let appDelegate: AppDelegate = UIApplication.shared.delegate as?
        AppDelegate else {
        return []
    }
    
    let managedContext: NSManagedObjectContext =
        appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<NSManagedObject> =
        NSFetchRequest<NSManagedObject>(entityName: "Try")
    
    do {
        return try managedContext.fetch(fetchRequest) as! [Try]
    } catch _ as NSError {
        return []
    }
}
