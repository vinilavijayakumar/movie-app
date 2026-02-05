//
//  MovieResponse.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

struct MovieResponse: Codable {
    let page: Int
    let results: [MovieItem]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
