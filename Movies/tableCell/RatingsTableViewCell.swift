//
//  RatingsTableViewCell.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import UIKit

/// This tableCiewCell is used to show Ratings in tableview
class RatingsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RatingsTableViewCell", bundle: nil)
    }
    
}
