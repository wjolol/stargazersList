//
//  StargazerCell.swift
//  stargazersList
//
//  Created by SERTORIG on 13/12/21.
//

import UIKit

class StargazerCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    
    func configure(with stargazerName: String) {
        nameLbl.text = stargazerName
    }
}
