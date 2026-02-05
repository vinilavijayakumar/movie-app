//
//  MovieListViewModel.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import Combine
import SwiftUI
import Foundation

@MainActor
final class MovieListViewModel: ObservableObject{
    
    enum FetchStatus {
    case notStarted
    case isLoaded
    case failed(underlyingError : Error)
    }
    
    @Published var list: [MovieItem] = []
    @Published var filteredList: [MovieItem] = []
    @Published var fetchStatus : FetchStatus = .notStarted
    @Published var isFetchingNextPage = false
    @Published var hasReachedEnd = false
    @Published var searchString : String = ""
    @Published var filter = MovieFilter()
    @Published var availableYears: [String] = []
    
    private var currentPage = 1
    private var totalPages = 1
    private var maxAllowedPages = 3
    
    
    func updateAvailableYears() {
        let years = Set(list.compactMap { $0.releaseYear })
        availableYears = Array(years).sorted(by: >)
    }
    
    func fetchInitialList() async throws{
        do {
            let response = try await NetworkRequestHandler().fetchData(
                urlstring: "\(APIEndpoints.homePageFetchUrlString)&page=\(currentPage)",
                responseType: MovieResponse.self)
            print("\(APIEndpoints.homePageFetchUrlString)&page=\(currentPage)")
            fetchStatus = .isLoaded
            currentPage = 2
            list = response.results
            CoreDataHelper().saveMoviesToCoreData(list)
            updateAvailableYears()
        }catch{
            fetchStatus = .failed(underlyingError: error)
            throw NetworkError.dataLoadingFailed(underlyingError: error)
        }
    }
    
    func fetchNextPageIfNeeded() async throws {
        guard !hasReachedEnd,
        !isFetchingNextPage else{ return }
        
        isFetchingNextPage = true
        
        do {
            let response = try await NetworkRequestHandler().fetchData(
                urlstring: "\(APIEndpoints.homePageFetchUrlString)&page=\(currentPage)",
                responseType: MovieResponse.self)
           print("\(APIEndpoints.homePageFetchUrlString)&page=\(currentPage)")
            let newItems = response.results.filter { newItem in
                !list.contains(where: { $0.id == newItem.id })
            }
            list.append(contentsOf: newItems)

            currentPage = currentPage + 1
            hasReachedEnd = currentPage == maxAllowedPages
            CoreDataHelper().saveMoviesToCoreData(list)
            updateAvailableYears()
        }catch{
            fetchStatus = .failed(underlyingError: error)
            throw NetworkError.dataLoadingFailed(underlyingError: error)
        }
        
        isFetchingNextPage = false
    }
    
    func loadFromCoreData(){
        list = CoreDataHelper().fetchMoviesFromCoreData()
        updateAvailableYears()
        fetchStatus = .isLoaded
        print("movies loaded from coredata")
    }
    
    
    func applyFilters(){
        filteredList = list.filter { movie in
            if !searchString.isEmpty &&
                !movie.title.localizedCaseInsensitiveContains(searchString){
                return false
            }
             
            if let year = filter.year, movie.releaseYear != year {
                return false
            }
            
            if let start = filter.startDate,
               let end = filter.endDate,
               let date = movie.releaseDateAsDate
                {
                    if date < start || date > end {
                        return false
                    }
            }
            
            return true
        }
    }
    
    func resetFilters(){
        searchString = ""
        filter = MovieFilter()
        filteredList.removeAll()
    }
    
    func refreshView() async throws{
        resetFilters()
        currentPage = 1
        hasReachedEnd = false
        do {
            try await fetchInitialList()
        }
        catch {
            throw NetworkError.dataLoadingFailed(underlyingError: error)
        }
    }
    
}
