//
//  TaskTableViewCell.swift
//  SmallBiz
//
//  Created by Benjamin Prentiss on 12/22/22.
//

import UIKit

protocol TaskStatusChangedProtocol: AnyObject {
    func updateTaskStatus(task: Task)
}

class TaskTableViewCell: UITableViewCell {

    weak var delegate: TaskStatusChangedProtocol?
    var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
