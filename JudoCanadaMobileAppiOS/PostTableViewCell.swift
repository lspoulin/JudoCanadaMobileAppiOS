//
//  PostTableViewCell.swift
//  
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelExerpt: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
