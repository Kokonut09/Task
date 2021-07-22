//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Andrew Saeyang on 7/21/21.
//

import UIKit



class TaskListTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskController.shared.loadFromPersistenceStore()
        
        
        //viewWillAppear(true)
        
    }

    // MARK: - Table view data source


    //MARK: - ACTIONS
    
    
    //MARK: - HELPER METHODS
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell()}

        //let task = TaskController.shared.tasks[indexPath.row]
        
        //cell.textLabel?.text = task.name
       
        cell.task = TaskController.shared.tasks[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            
            
            TaskController.shared.delete(task: taskToDelete)
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Identifier
        if segue.identifier == "loadTaskToVC"{
            
            // Index Path
            // Destination
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else {return}
            
            // Object to send
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            
            // Object to Recieve
            destination.task = taskToSend
            
        }
        
        /*else if segue.identifier == "createNewTaskVC"{
            
            // Destination
            guard let destination = segue.destination as? TaskDetailViewController else {return}
            
            // Object to Recieve
            
        }
        */
    
    }
} //End of class


extension TaskListTableViewController: TaskCompletionDelegate{
    func taskCellButtonTapped (_ sender: TaskTableViewCell){
        sender.task?.isComplete.toggle()
        sender.updateViews()
        
        TaskController.shared.saveToPersistenceStore()
    }
    
}
