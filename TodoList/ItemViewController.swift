
//
//  ItemViewController.swift
//  TodoList
//
//  Created by AgribankCard on 2/26/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import CoreData
class ItemViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var itemTableView: UITableView!
    var manageObjectContext = CoreDataStack.sharedInstance.context
    @IBOutlet weak var textField: UITextField!
    var currentTodo : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = currentTodo?.name
        itemTableView.delegate = self
        itemTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemTableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName = segue.identifier
        if  segueName == "addDetailItem" {
            let navagationController = segue.destination as! UINavigationController
            let detailItemVC = navagationController.topViewController! as! DetailItemViewController
            detailItemVC.currentItem = currentTodo
        }
    }
    @IBAction func addDetailItem(_ sender: Any) {
        self.performSegue(withIdentifier: "addDetailItem", sender: self)
    }
    
    @IBAction func save(_ sender: Any) {
        
        let isPresenting = self.isPresenting()
        
        if isPresenting {
            guard let text = textField.text else { return }
            let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.manageObjectContext) as? Item
            item?.name = text
            
            //item?.titleSection = "section 2"
            
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
    //MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTodo?.detailItems?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetailItem", for: indexPath)        
        // Configure the cell...
        let detailItem = currentTodo?.detailItems?[indexPath.row] as! DetailItem
        cell.textLabel?.text = detailItem.nameDetail
        return cell
    }
    
    
}
