//
//  ProductTableViewCell.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 13/12/2020.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewTab: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
    
}
