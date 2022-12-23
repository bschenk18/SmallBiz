//
//  task.swift
//  SmallBiz
//
//  Created by Benjamin Prentiss on 12/21/22.
//

import Foundation

class Task: Codable, Equatable {
    var title: String
    var isComplete: Bool
    var id: String
    
    init(title: String, isComplete: Bool = false, id: String = UUID().uuidString) {
        self.title = title
        self.isComplete = isComplete
        self.id = id
    }
    
    //Equatable Conformance
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
