//
//  ViewController.swift
//  movie_list_app
//
//  Created by Kiran on 18/07/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieListTV: UITableView!
    
    //MARK: - Local Variables
    private var viewModel = MovieListVM()
    var movieListModal : MovieListModal?
    var movieModal : MovieModal?
    var page : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieListTV.delegate = self
        self.movieListTV.dataSource = self
        self.movieListTV.register(UINib(nibName: "MovieListTVC", bundle: nil), forCellReuseIdentifier: "MovieListTVC")
    }
    
    //MARK: - getMovieList
    func getMovieList() {
        viewModel.getMovieList(page: self.page) { data in
            self.movieListModal = data
        }
    }
    
    //MARK: - getMovieDetails()
    func getMovieDetails(movieID : Int) {
        viewModel.getMovieDetails(movieID: movieID) { data in
            self.movieModal = data
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataModel = movieListModal else {return 0}
        return dataModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataModel = movieListModal else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTVC", for: indexPath) as! MovieListTVC
        let dataForIndex = dataModel.results[indexPath.row]
        let imagePath = dataForIndex.posterPath
        cell.movieImage.sd_setImage(with: URL(string: Constants.imageBaseUrl+imagePath))
        cell.movieNameLbl.text = dataForIndex.originalTitle
        cell.movieRatingLbl.text = "★ \(dataForIndex.voteAverage) & \(dataForIndex.voteCount) counts"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataModel = movieModal else {return}
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        vc.movieDetailModal = dataModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

