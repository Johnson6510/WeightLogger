//
//  WeightLog.swift
//  WeightLogger
//
//  Created by 黃健偉 on 2017/12/23.
//  Copyright © 2017年 黃健偉. All rights reserved.
//

import UIKit
import CoreData

class WeightLog: UITableViewController {

    var totalEntries: Int = 0
    
    @IBOutlet var tblLog: UITableView!
    
    @IBAction func btnCleanLog(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        let results: NSArray = try! context.fetch(request) as NSArray
        
        for weightEntry: Any in results {
            context.delete(weightEntry as! NSManagedObject)
        }
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = 0
        tblLog?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        let results: NSArray = (try? context.fetch(request)) as NSArray!
        totalEntries = results.count
        //print (totalEntries)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalEntries    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.fetch(request)) as NSArray!
        
        //get contents and put into cell
        let thisWeight: UserWeights = results[indexPath.row] as! UserWeights
        cell.textLabel?.text = thisWeight.weight! + " " + thisWeight.units!
        cell.detailTextLabel?.text = thisWeight.date
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //delete object from entity, remove from list
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.fetch(request)) as NSArray!
        
        //Get value that is being deeleted
        let tmpObject: NSManagedObject = results[indexPath.row] as! NSManagedObject
        let delWeight = tmpObject.value(forKey: "weight") as? String
        print("Deleted Weight: \(delWeight ?? "0")")
        
        context.delete(results[indexPath.row] as! NSManagedObject)
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = totalEntries - 1
        tableView.deleteRows(at: [indexPath], with: .fade)
        print("Done")
    }

    
 
 


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
