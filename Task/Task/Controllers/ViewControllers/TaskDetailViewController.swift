//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Andrew Saeyang on 7/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var task: Task?
    var date: Date?

    //MARK: - OUTLETS
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        // Do any additional setup after loading the view.
    }
    //MARK: - HELPER METHODS
    
    func updateViews(){
        guard let task = task else {
            date = taskDueDatePicker.date
            return}
        
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        
        //Cannot set taskduedate picker because dueDate is optional, need to nil coalece (sp) aka all optionals are enums and cannot set data type to one. Lee is smart
        taskDueDatePicker.date = task.dueDate ?? Date()
        
   
    }
    
    //MARK: - ACTIONS
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = taskNameTextField.text, !name.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        
        if let task = task{
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: date)
            
        }else{
                
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        guard let datePicker = taskDueDatePicker else { return }
        
        date = datePicker.date
        
        
    }
}
