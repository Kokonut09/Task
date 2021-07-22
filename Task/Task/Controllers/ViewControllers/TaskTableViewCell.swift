//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Andrew Saeyang on 7/21/21.
//

import UIKit

//Declare protocol > making it confomr to AnyObject
protocol TaskCompletionDelegate: AnyObject{
  //leave it as a declaration
    func taskCellButtonTapped (_ sender: TaskTableViewCell)
    
}

class TaskTableViewCell: UITableViewCell {

    
    
    var task: Task?{
        didSet{
            updateViews()
        }
    }
    
    //MARK: - OUTLETS
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //MARK: - DELEGATE PROPERTY
    weak var delegate: TaskCompletionDelegate?
    
    //MARK: - ACTIONS
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
        
    }
    
    
    //MARK: - HELPER METHOD
    
    func updateViews(){
        guard let task = task else{ return }
        
        taskNameLabel.text = task.name
        if task.isComplete == true{
            
            completionButton.setBackgroundImage(UIImage(named: "complete"), for:.normal)
            
        }else{
            
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for:.normal)
            
        }
        
        
    }
}//End of class
