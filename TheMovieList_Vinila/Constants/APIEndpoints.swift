//
//  APIEndpoints.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

class APIEndpoints{
    static let apiKey = "c38629cc979d71c3c073206725706c21"
    static let apiBaseURL = "https://api.themoviedb.org/3/movie"
    static let popularMovieQuery = "/popular?api_key="
    static let homePageFetchUrlString = apiBaseURL + popularMovieQuery + apiKey
    static let posterImageBaseUrl = "https://image.tmdb.org/t/p/w500"
}
/*
 Popular Movies: https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY
 Now Playing: https://api.themoviedb.org/3/movie/now_playing?api_key=YOUR_API_KEY
 Upcoming: https://api.themoviedb.org/3/movie/upcoming?api_key=YOUR_API_KEY
 Top Rated: https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY
 Discover/Filter: https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=28
 */
