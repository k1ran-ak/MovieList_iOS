//
//  ViewController.swift
//  movie_list_app
//
//  Created by Kiran on 18/07/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieListTV: UITableView!
    
    //MARK: - Local Variables
    private var viewModel = MovieListVM()
    var movieListModal : MovieListModal?
    var movieModal : MovieModal?
    var page : Int = 1
    lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    var filteredList = [Result]()
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie List"
        self.movieListTV.delegate = self
        self.movieListTV.dataSource = self
        self.movieSearchBar.delegate = self
        self.movieListTV.register(UINib(nibName: "MovieListTVC", bundle: nil), forCellReuseIdentifier: "MovieListTVC")
        getMovieList()
    }
    
    //MARK: - getMovieList
    func getMovieList() {
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        viewModel.getMovieList(page: self.page) { data in
            self.movieListModal = data
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.movieListTV.reloadData()
        }
    }
    
    //MARK: - getMovieDetails()
    func getMovieDetails(movieID : Int) {
        viewModel.getMovieDetails(movieID: movieID) { data in
            self.movieModal = data
            guard let dataModel = self.movieModal else {return}
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
            vc.movieDetailModal = dataModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataModel = movieListModal else {return 0}
        return isFiltering ? filteredList.count : dataModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataModel = movieListModal else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTVC", for: indexPath) as! MovieListTVC
        let dataForIndex = isFiltering ? filteredList[indexPath.row] : dataModel.results[indexPath.row]
        let imagePath = dataForIndex.posterPath
        cell.movieImage.sd_setImage(with: URL(string: Constants.imageBaseUrl+imagePath))
        cell.movieNameLbl.text = dataForIndex.title
        cell.movieRatingLbl.text = "★ \(dataForIndex.voteAverage) & \(dataForIndex.voteCount) counts"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataModel = movieListModal else {return}
        let dataForIndex = isFiltering ? filteredList[indexPath.row] : dataModel.results[indexPath.row]
        getMovieDetails(movieID: dataForIndex.id)
    }
    
    //MARK: - Searchbar delegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("Search for: ",searchText)
            self.updateTV(searchText)
        }
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            self.view.endEditing(true)
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.view.endEditing(true)
        }
        func updateTV(_ searchText : String) {
            guard let dataModel = movieListModal else {return}
            if searchText.isEmpty {
                filteredList.removeAll()
                isFiltering = false
            } else {
                filteredList = dataModel.results.filter{$0.title.range(of: searchText, options: .caseInsensitive) != nil }
                isFiltering = true
            }
            movieListTV.reloadData()
        }
    
    
}

