//
//  MovieListTVC.swift
//  movie_list_app
//
//  Created by Kiran on 18/07/22.
//

import UIKit

class MovieListTVC: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
