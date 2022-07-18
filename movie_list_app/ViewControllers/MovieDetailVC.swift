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
        self.initDatas()
  
    }
    
    func initDatas() {
        self.movieImage.sd_setImage(with: URL(string: Constants.imageBaseUrl+movieDetailModal.backdropPath))
        self.movieNameLbl.text = movieDetailModal.title
        self.movieDurationLbl.attributedText = attributedBoldString(key: "Duration : ", value: "\(movieDetailModal.runtime) minutes")
        self.movieDateLbl.attributedText = attributedBoldString(key: "Release Date : ", value: "\(movieDetailModal.releaseDate)")
        var genres = ""
        movieDetailModal.genres.forEach { data in
            genres += " "+data.name
        }
        genres.remove(at: genres.firstIndex(of: " ")!)
        let newGenres = genres.replacingOccurrences(of: " ", with: ", ")
        self.movieGenresLbl.attributedText = attributedBoldString(key: "Genres : ", value: newGenres)
        self.movieRatingLbl.attributedText = attributedBoldString(key: "Rating and Votes : ", value: "★ \(movieDetailModal.voteAverage) & \(movieDetailModal.voteCount)")
        self.movieAboutLbl.attributedText = attributedBoldString(key: "About : ", value: "\(movieDetailModal.overview)")
        self.movieCastLbl.attributedText = attributedBoldString(key: "Revenue : ", value: "$ \(movieDetailModal.revenue)")
    }
    
    func attributedBoldString(key : String, value : String) -> NSMutableAttributedString {
        let keyAttribute = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ]
        let keyAttributedString = NSMutableAttributedString(string: key, attributes: keyAttribute)
        
        let valueAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.regular) ]
        let valueAttributedString = NSMutableAttributedString(string: value, attributes: valueAttribute)
        keyAttributedString.append(valueAttributedString)
        return keyAttributedString
    }


}
