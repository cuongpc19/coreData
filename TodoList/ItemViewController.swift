
//
//  ItemViewController.swift
//  TodoList
//
//  Created by AgribankCard on 2/26/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import CoreData
class ItemViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    @IBAction func save(_ sender: Any) {
        guard let text = textField.text else { return }
        let appdelegate = AppDelegate()
        let manageObjectContext = appdelegate.persistentContainer.viewContext
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: manageObjectContext) as! Item
        item.name = text
        
        do {
             try manageObjectContext.save()
            
        }
        catch let error as NSError
        {
            print("error: \(error)")
        }
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
