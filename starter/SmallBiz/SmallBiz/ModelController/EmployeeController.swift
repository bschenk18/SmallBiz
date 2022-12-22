//
//  EmployeeController.swift
//  SmallBiz
//
//  Created by Benjamin Prentiss on 12/20/22.
//

import Foundation

class EmployeeController {
    
    // Shared Instance
    static let shared = EmployeeController()
    
    // Source of Truth
    var employees: [Employee] = []
    
    var defaultItems: [String] = [
        "Payroll",
        "Onboarding",
        "Employee Profile",
        "Work shoes",
    ]
    
    // MARK: - CRUD
    func addEmployee(firstName: String, lastName: String) {
        // Declare a new employee object
        let newEmployee = Employee(firstName: firstName, lastName: lastName)
        
        // Add that employee to our source of truth
        employees.append(newEmployee)
        print("Successfully added a \(newEmployee.firstName) to our list of employees.")
        
        // Save
        saveToPersistenceStore()
    }
    
    func delete(employee: Employee) {
        // Make sure we get the index of the employee
        guard let index = employees.firstIndex(of: employee) else { return }
        
        // Remove employee
        employees.remove(at: index)
        print("Successfully removed \(employee.firstName).")
        
        // Save
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("SmallBiz.json")
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(employees)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our employees: \(error) -- \(error.localizedDescription)")
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            employees = try JSONDecoder().decode([Employee].self, from: data)
        } catch {
            print("Error decoding our data into employee: \(error) -- \(error.localizedDescription)")
        }
    }
    
}
