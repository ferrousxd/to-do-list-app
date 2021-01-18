//
//  TableViewController.swift
//  Assignment1
//
//  Created by Чингиз Азимбаев on 18.01.2021.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var array = [ToDoItem]()
    let cellId = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        testDataConfigure()
    }
    
    func testDataConfigure() {
        array.append(ToDoItem(id: 1, title: "First", subtitle: "First Subtitle", status: "In Progress", deadline: "20.12.2021"))
        array.append(ToDoItem(id: 2, title: "Second", subtitle: "Second Subtitle", status: "Done", deadline: "22.12.2021"))
        array.append(ToDoItem(id: 3, title: "Third", subtitle: "Third Subtitle", status: "In Progress", deadline: "12.08.2021"))
        array.append(ToDoItem(id: 4, title: "Fourth", subtitle: "Fourth Subtitle", status: "Done", deadline: "05.07.2021"))
        array.append(ToDoItem(id: 5, title: "Fifth", subtitle: "Fifth Subtitle", status: "In Progress", deadline: "29.12.2021"))
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = array[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.subtitle
        cell.statusLable.text = item.status
        cell.deadlineLabel.text = item.deadline
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            print("Edit")
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        let addAction = UIContextualAction(style: .normal, title: "Add") { (action, view, completion) in
            print("Add")
        }
        
        addAction.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.01396386574, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [editAction, addAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { (action, view, completion) in
            self.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}
