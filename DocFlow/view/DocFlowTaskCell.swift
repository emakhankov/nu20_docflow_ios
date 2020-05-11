//
//  DocFlowTaskCell.swift
//  DocFlow
//
//  Created by Evgeny Makhankov on 11.05.2020.
//  Copyright © 2020 Evgeny Makhankov. All rights reserved.
//

import UIKit

class DocFlowTaskCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateCell(docflowtask: DocFlowTask)
    {
        self.name.text = docflowtask.name
    }

}
