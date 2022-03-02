//
//  ViewController.swift
//  Time Manager
//
//  Created by admin on 23.02.22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tasksTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
