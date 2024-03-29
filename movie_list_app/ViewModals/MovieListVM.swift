//
//  MovieListVM.swift
//  movie_list_app
//
//  Created by Kiran on 18/07/22.
//

import Foundation
import Alamofire

class MovieListVM : NSObject {
    
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })
        return Session(
          configuration: configuration,
          cachedResponseHandler: responseCacher)

    }()
    
    func getMovieList(page : Int,completion:@escaping(MovieListModal) -> ()) {
        let request = sessionManager.request("https://api.themoviedb.org/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=\(page)")
        request.responseDecodable(of: MovieListModal.self) { respose in
            guard let data = respose.value else {return}
            completion(data)
        }
    }
    
    func getMovieDetails(movieID : Int ,completion:@escaping(MovieModal) -> ()) {
        let request = sessionManager.request("https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(Constants.apiKey)")
        request.responseDecodable(of: MovieModal.self) { respose in
            guard let data = respose.value else {return}
            completion(data)
        }
    }
}
