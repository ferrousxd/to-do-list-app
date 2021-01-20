//
//  TableViewController.swift
//  Assignment1
//
//  Created by Чингиз Азимбаев on 18.01.2021.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func addToDoItem(_ newToDoItem: ToDoItem)
    func editToDoItem(_ id: Int, _ newToDoItem: ToDoItem)
}

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var array = [ToDoItem](arrayLiteral:
        ToDoItem(title: "First", subtitle: "First Subtitle", status: "In Progress", deadline: "2021-12-20"),
        ToDoItem(title: "Second", subtitle: "Second Subtitle", status: "Done", deadline: "2021-12-22"),
        ToDoItem(title: "Third", subtitle: "Third Subtitle", status: "In Progress", deadline: "2021-12-08"),
        ToDoItem(title: "Fourth", subtitle: "Fourth Subtitle", status: "Done", deadline: "2021-05-07"),
        ToDoItem(title: "Fifth", subtitle: "Fifth Subtitle", status: "In Progress", deadline: "2021-12-29")
    )
    let cellId = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addNewToDoItem(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddTableCellViewController") as! AddTableCellViewController

        vc.delegate = self

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController: TableViewControllerDelegate {
    
    func editToDoItem(_ id: Int, _ newToDoItem: ToDoItem) {
        array[id] = newToDoItem
        tableView.reloadData()
    }
    
    func addToDoItem(_ newToDoItem: ToDoItem) {
        array.append(newToDoItem)
        print(newToDoItem)
        tableView.insertRows(at: [IndexPath(row: array.count, section: 0)], with: .automatic)
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
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            let vc = self.storyboard?.instantiateViewController(identifier: "EditTableCellViewController") as! EditTableCellViewController
            
            vc.selectedToDoItemIndex = indexPath.row
            vc.selectedToDoItem = self.array[indexPath.row]
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}
