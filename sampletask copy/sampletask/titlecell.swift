//
//  TableViewCell.swift
//  sampletask
//
//  Created by Vinay on 17/02/24.
//

import UIKit

class titlecell: UITableViewCell {
    
    
    @IBOutlet weak var labl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
