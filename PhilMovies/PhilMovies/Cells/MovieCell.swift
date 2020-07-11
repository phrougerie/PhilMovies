//
//  MovieCell.swift
//  PhilMovies
//
//  Created by Philippe ROUGERIE on 13/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//

import UIKit

class  MovieCell: UITableViewCell {
    static let identifier = "MovieCell"
    
    @IBOutlet weak var moviename: UILabel!
    required init?(coder: NSCoder) {
        NSLog("in init of MovieCell")
        super.init(coder:coder)
    }
}
