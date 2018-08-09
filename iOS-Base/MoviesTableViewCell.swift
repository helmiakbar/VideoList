//
//  MoviesTableViewCell.swift
//  iOS-Base
//
//  Created by Helmi Akbar on 08/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
