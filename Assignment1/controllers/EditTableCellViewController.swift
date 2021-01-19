//
//  EditTableCellViewController.swift
//  Assignment1
//
//  Created by Чингиз Азимбаев on 19.01.2021.
//

import UIKit

class EditTableCellViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var subtitleLabel: UITextField!
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    var selectedToDoItemIndex: Int?
    var selectedToDoItem: ToDoItem?
    var delegate: TableViewControllerDelegate?
    var statusData = [String]()
    
    var updatedTitle: String?
    var updatedSubtitle: String?
    var updatedStatus: String?
    var updatedDeadline: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedToDoItem?.title
        subtitleLabel.text = selectedToDoItem?.subtitle
        
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

        updatedStatus = statusData[row]
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: sender.date)
        
        updatedDeadline = selectedDate
    }
    
    @IBAction func submitAction(_ sender: Any) {
        // Checking title for nil
        updatedTitle = titleLabel.text
        
        if updatedTitle == nil {
            updatedTitle = selectedToDoItem?.title
        }
        
        // Checking subtitile for nil
        updatedSubtitle = subtitleLabel.text
        
        if updatedSubtitle == nil {
            updatedSubtitle = selectedToDoItem?.subtitle
        }
        
        // Checking status for nil
        if updatedStatus == nil {
            updatedStatus = selectedToDoItem?.status
        }
        
        // Checking deadline for nil
        if updatedDeadline == nil {
            updatedDeadline = selectedToDoItem?.deadline
        }
        
        delegate?.editToDoItem(selectedToDoItemIndex ?? 0, ToDoItem(title: updatedTitle, subtitle: updatedSubtitle, status: updatedStatus, deadline: updatedDeadline))
        
        self.navigationController?.popViewController(animated: true)
    }
}
