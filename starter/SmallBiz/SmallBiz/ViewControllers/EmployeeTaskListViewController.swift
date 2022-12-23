//
//  EmployeeTaskListViewController.swift
//  SmallBiz
//
//  Created by Benjamin Prentiss on 12/21/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskTableView: UITableView!
    
    
    // MARK: - Properties
    var employee: Employee?
    
    override func loadView() {
        super.loadView()
        setViewTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Any other setup can be done here
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    func setViewTitle() {
        guard let employee = employee else {
            print("employee object was found nill when calling setViewTitle func")
            return}
        self.navigationItem.title = "\(employee.firstName)'s Tasks"
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = taskTextField.text, !text.isEmpty else { return }
        guard let employee = employee else {return}
        TaskController.assignTaskTo(employee, taskTitle: text)
        taskTextField.text = ""
        taskTextField.resignFirstResponder()
        taskTableView.reloadData()
    }
}

extension EmployeeTaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employee?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        guard let employee = employee else {return
            UITableViewCell()
        }
        let task = employee.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let employee = employee else {return}
        if editingStyle == .delete {
            let taskToDelete = employee.tasks[indexPath.row]
            TaskController.deleteTaskFrom(employee, taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension EmployeeTaskListViewController: TaskStatusChangedProtocol {
    func updateTaskStatus(task: Task) {
        guard let employee = employee else {return}
        TaskController.toggleTaskStatus(employee: employee, task: task)
        taskTableView.reloadData()
    }
}
