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
    
    
    init(firstName: String, lastName: String, skillLevel: Int = 0, id: String = UUID().uuidString){
        
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.id = id
        
    }
    
    // Equatable Conformance
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
    
}

