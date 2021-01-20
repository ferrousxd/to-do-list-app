//
//  AddTableCellViewController.swift
//  Assignment1
//
//  Created by Чингиз Азимбаев on 20.01.2021.
//

import UIKit

class AddTableCellViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var subtitleLabel: UITextField!
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    weak var delegate: TableViewControllerDelegate?
    var statusData = [String]()
    
    var newTitle: String?
    var newSubtitle: String?
    var newStatus: String?
    var newDeadline: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create New To-Do Item"
        
        titleLabel.delegate = self
        subtitleLabel.delegate = self

        self.statusPicker.delegate = self
        self.statusPicker.dataSource = self
        
        statusData = ["In Progress", "Done"]
        
        deadlinePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < statusData.count else {
            return
        }

        newStatus = statusData[row]
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: sender.date)
        
        newDeadline = selectedDate
    }
    
    @IBAction func submitAction(_ sender: Any) {
        // Checking title for nil
        newTitle = titleLabel.text
        
        if newTitle == "" || newTitle == nil {
            newTitle = "Sample Text"
        }
        
        // Checking subtitile for nil
        newSubtitle = subtitleLabel.text
        
        if newSubtitle == "" || newTitle == nil {
            newSubtitle = "Sample Text"
        }
        
        // Checking status for nil
        if newStatus == nil {
            newStatus = "In Progress"
        }
        
        // Checking deadline for nil
        if newDeadline == nil {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            newDeadline = dateFormatter.string(from: date)
        }
        
        delegate?.addToDoItem(ToDoItem(title: newTitle, subtitle: newSubtitle, status: newStatus, deadline: newDeadline))

        self.navigationController?.popViewController(animated: true)
    }
}
