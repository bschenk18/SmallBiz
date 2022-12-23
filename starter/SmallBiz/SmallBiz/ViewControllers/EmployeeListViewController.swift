//
//  EmployeeListViewController.swift
//  SmallBiz
//
//  Created by Benjamin Prentiss on 12/21/22.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var employeeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EmployeeController.shared.loadFromPersistenceStore()
    }
    
    func setupTableView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        // Make sure our text is not empty.
        guard let text = employeeTextField.text,
              !text.isEmpty else { return }
        
        // Split first and last name
        let fullName = text.components(separatedBy: " ")
        
        if fullName.count >= 2 {
            
        EmployeeController.shared.addEmployee(firstName: fullName[0], lastName: fullName[1])
        }else{
        EmployeeController.shared.addEmployee(firstName: fullName[0], lastName: "")
        }
        
        employeeTextField.text = ""
        employeeTextField.resignFirstResponder()
        tableView.reloadData()
    }
}
extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EmployeeController.shared.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        
        let employee = EmployeeController.shared.employees[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(employee.firstName) \(employee.lastName)"
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete = EmployeeController.shared.employees[indexPath.row]
            EmployeeController.shared.delete(employee: employeeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //Verify the segue is the correct one, by checking the segue ID
        if segue.identifier == "toTaskView" {
            //Identify where it is we want to segue to
            guard let destinationViewController =
                    segue.destination as? EmployeeTaskListViewController else {
                print("There was an error with the destinationViewController")
                return
            }
            //Identify what row was tapped on (the index)
            guard let indexPath = tableView.indexPathForSelectedRow else {
                print("There was an error with obtaining the index path")
                return
            }
            
            //Identiy what it is we want to pass along
            let selectedEmployee = EmployeeController.shared.employees[indexPath.row]
            
            //Reception :D Make the pass
            destinationViewController.employee = selectedEmployee
        }
        
    
    }
}
