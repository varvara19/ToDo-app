//
//  TableViewController.swift
//  myApp2
//
//  Created by Sunrise Sunrise on 8/20/20.
//  Copyright © 2020 Sunrise Sunrise. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController{

   
    var tasks = [Task]()
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new task", message: "Please enter tour task", preferredStyle: .alert)
        let save = UIAlertAction(title: "save", style: .default) { (action) in
            
            let textField1 = alert.textFields?.first
            let textField2 = alert.textFields?.last
            if let newTaskTitle = textField1?.text, let newDescription = textField2?.text {
                self.saveInfotmation(withTitle: newTaskTitle, withDescription: newDescription)
                self.tableView.reloadData()
            }

        }
        let cancel = UIAlertAction(title: "cancel", style: .destructive) {(_) in }
        
        
        alert.addAction(save)
        alert.addAction(cancel)
        alert.addTextField { (textField1) in
            textField1.placeholder = "Title"
            textField1.borderStyle = UITextField.BorderStyle.roundedRect
        }
        alert.addTextField { (textField2) in
            textField2.placeholder = "Description"
            textField2.borderStyle = UITextField.BorderStyle.roundedRect
            
        }
        
        present(alert, animated: true,completion: nil)
        
        for textField in alert.textFields! {
            let container = textField.superview
            let effectView = container?.superview?.subviews[0]
            if (effectView != nil) {
                container?.backgroundColor = UIColor.clear
                effectView?.removeFromSuperview()
            }
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let task = tasks[indexPath.row]
        cell.editButton.isHidden = true
        
        cell.textLabel?.text = "№ " + String(indexPath.row + 1) + ": " + task.titleTask!
        cell.detailTextLabel?.text = task.descriptionTask
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.systemGray6
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        if cell.isSelected == true {
            cell.editButton.isHidden = false
            
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        if cell.isSelected == false {
            cell.editButton.isHidden = true
           
        }
    }
    private func saveInfotmation(withTitle title: String, withDescription description: String) {
           let context = createContext()
           guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {return}
           let taskObject = Task(entity: entity, insertInto: context)
           taskObject.titleTask = title
           taskObject.descriptionTask = description
           
           do {
               try context.save()
               tasks.append(taskObject)
           } catch {
               print("error")
           }
       }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier  == "MoreInfo" {
        guard let destinationViewController = segue.destination
            as? ViewController else {return}
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
        
        destinationViewController.titleText = tasks[selectedRow].titleTask!
            destinationViewController.descriptionText = tasks[selectedRow].descriptionTask!
            
        }
        
    }
    @IBAction func unwindSegue( sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController {
           let context = createContext()
            guard let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
            tasks[selectedRow].titleTask! = sourceViewController.titleTF.text!
            tasks[selectedRow].descriptionTask! = sourceViewController.descriptionTF.text!
            do {
             try context.save()
            } catch {
                print ("error")
            }
           
        tableView.reloadData()
    
    }
}
    
    private func createContext() ->NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let contex = createContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            tasks = try contex.fetch(fetchRequest)
        } catch{
            print ("error")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let context = createContext()
            context.delete(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
        }
    }
}





