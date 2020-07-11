//
//  DetailViewController.swift
//  PhilMovies
//
//  Created by Philippe ROUGERIE on 02/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//

import UIKit
import MoviesFramework

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var overivewLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var thePopularity: UILabel!
    
    @IBOutlet weak var originalTitle: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.title
                overivewLabel.text = detail.overview
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "DD/MM/YYYY"
                date.text = dateFormatter.string(from: detail.releaseDate)
                thePopularity.text = String(detail.popularity)
                originalTitle.text = detail.originalTitle
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Movie? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

