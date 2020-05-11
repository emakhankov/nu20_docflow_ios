//
//  ViewController.swift
//  DocFlow
//
//  Created by Evgeny Makhankov on 11.05.2020.
//  Copyright © 2020 Evgeny Makhankov. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var doclowtasks = Array<DocFlowTask>()
    
    @IBOutlet weak var docflowtasksTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        docflowtasksTable.delegate = self
        docflowtasksTable.dataSource = self
        
        debugPrint("start getdftasks")
        getDocFlowTasks()
    }


    func getDocFlowTasks()
    {
        NetworkService.shared.getTasks(onSuccess: { (doclowtasks) in
            self.doclowtasks = doclowtasks
            self.docflowtasksTable.reloadData()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DocFlowTaskCell") as? DocFlowTaskCell {
            cell.updateCell(docflowtask: doclowtasks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    //  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //      return 50
    //  }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doclowtasks.count
    }

}

