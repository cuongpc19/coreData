
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
    
    var manageObjectContext = CoreDataStack.sharedInstance.context
    @IBOutlet weak var textField: UITextField!
    var currentTodo : Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = currentTodo?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    @IBAction func save(_ sender: Any) {
        
        let isPresenting = self.isPresenting()
        
        if isPresenting {
            guard let text = textField.text else { return }
            let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.manageObjectContext) as? Item
            item?.name = text
            
            do {
                try manageObjectContext.save()
            }
            catch let error as NSError
            {
                print("error: \(error)")
            }
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            guard let text = textField.text else { return }
            currentTodo?.name = text
            do {
                try manageObjectContext.save()
            }
            catch let error as NSError
            {
                print("error: \(error)")
            }
            owningNavigationController.popViewController(animated: true)

        }
        
    }
   
    @IBAction func cancel(_ sender: Any) {
        let isPresenting = self.isPresenting()
        
        if isPresenting {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ItemVC is not inside a navigation controller.")
        }
    }
    func isPresenting() -> Bool {
        let isPresenting = presentingViewController is UINavigationController
        
        if isPresenting {
            return true
        }
        else {
            return false
        }
    }
}
