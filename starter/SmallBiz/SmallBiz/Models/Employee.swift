//
//  Employee.swift
//  SmallBiz
//
//  Created by Benjamin Prentiss on 12/20/22.
//

import Foundation

class Employee: Codable, Equatable {
    var firstName: String
    var lastName: String
    var skillLevel: Int
    var id: String
    var tasks: [Task]
    
    
    init(firstName: String, lastName: String, skillLevel: Int = 0, id: String = UUID().uuidString, tasks: [Task] = []){
        
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.id = id
        self.tasks = tasks
        
    }
    
    // Equatable Conformance
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
    
}

