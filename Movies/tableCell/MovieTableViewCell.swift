//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import UIKit

/// This tableCiewCell is used to show movie name and other information related to movie in tableview
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblRelease: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
}
