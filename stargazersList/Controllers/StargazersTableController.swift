//
//  StargazersTableController.swift
//  stargazersList
//
//  Created by SERTORIG on 13/12/21.
//

import UIKit

class StargazersTableController: UIViewController {
    
    var stargazersList: [String]?
    
    override func viewDidLoad() { }
}

extension StargazersTableController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stargazersList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stargazerCell", for: indexPath) as! StargazerCell
        cell.configure(with: (stargazersList?[indexPath.row])!)
        return cell
    }
}
