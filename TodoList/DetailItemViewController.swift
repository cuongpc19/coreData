//
//  DetailItemViewController.swift
//  TodoList
//
//  Created by AgribankCard on 2/28/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import CoreData
class DetailItemViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var currentItem : Item?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func save(_ sender: Any) {
        let managedObjectContext = CoreDataStack.sharedInstance.context
        let DetailEntity = NSEntityDescription.entity(forEntityName: "DetailItem", in: managedObjectContext)                
        let newDetailItem = DetailItem(entity: DetailEntity!, insertInto:  managedObjectContext)
        newDetailItem.nameDetail = textField.text
        let detailItems = currentItem?.detailItems?.mutableCopy() as! NSMutableOrderedSet
        
        detailItems.add(newDetailItem)
        currentItem?.detailItems = detailItems.copy() as? NSOrderedSet
        do {
            try managedObjectContext.save()
        }
        catch let error as NSError {
            print("Could not save:\(error)")
        }

        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
