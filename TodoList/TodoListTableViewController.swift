//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by AgribankCard on 2/26/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import CoreData
class TodoListTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    var items : [Item] = []
    var manageObjectContext = CoreDataStack.sharedInstance.context
    var fetchedResultsController: NSFetchedResultsController<Item>!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController?.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        //tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchData() {
        
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let entityDescription = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [entityDescription]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: manageObjectContext, sectionNameKeyPath: "titleSection", cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            //let results = try manageObjectContext.fetch(fetchRequest) as [Item]
            //items = results
            try fetchedResultsController?.performFetch()
        }
        catch let error as NSError {
            print("error: \(error)")
        }
        //tableView.reloadData()

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = fetchedResultsController?.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = items[indexPath.row].name
        // Configure the cell...
        guard let selectedObject = fetchedResultsController.object(at: indexPath as IndexPath) as? Item else { fatalError("Unexpected Object in FetchedResultsController") }
        cell.textLabel?.text = selectedObject.name
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let theSection = (fetchedResultsController.sections?[section])! as NSFetchedResultsSectionInfo
        let sectionName = theSection.name
        return sectionName
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let currentItem = items[indexPath.row]
            manageObjectContext.delete(currentItem)
            do {
                try manageObjectContext.save()
            }
            catch let error as NSError
            {
                print("error: \(error)")
            }
            //tableView.deleteRows(at: [indexPath], with: .fade)
            fetchData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let segueName = segue.identifier
        if segueName == "addTodo" {
            guard let destination = segue.destination as? ItemViewController else {
                return
            }
           
            //destination.manageObjectContext = self.manageObjectContext
        }
        else if (segueName == "editTodo") {
            guard let destination = segue.destination as? ItemViewController else {
                return
            }
            let selectedCell = tableView.indexPathsForSelectedRows?.first
            
            destination.currentTodo = fetchedResultsController.object(at: selectedCell!) as? Item
        }
        else if (segueName == "addDetailItem") {
            print("addDetailItem")
        }
    }
    func configureCell(_ cell: UITableViewCell, withEvent item: Item) {
        cell.textLabel?.text = item.name
    }
    //MARK: NSFetchResultController
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Item)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
}

