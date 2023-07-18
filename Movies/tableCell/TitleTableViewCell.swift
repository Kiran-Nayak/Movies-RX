//
//  TitleTableViewCell.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import UIKit

/// This tableCiewCell is used to show title cell in tableview
class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TitleTableViewCell", bundle: nil)
    }
    
}
