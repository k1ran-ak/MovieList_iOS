//
//  MovieDetailVC.swift
//  movie_list_app
//
//  Created by Kiran on 18/07/22.
//

import UIKit

class MovieDetailVC: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieDurationLbl: UILabel!
    @IBOutlet weak var movieDateLbl: UILabel!
    @IBOutlet weak var movieGenresLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var movieAboutLbl: UILabel!
    @IBOutlet weak var movieCastLbl: UILabel!
    
    //MARK: - Local Variables
    var movieDetailModal : MovieModal!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    


}
