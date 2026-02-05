//
//  MovieItem.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import Foundation

struct MovieItem: Codable, Identifiable, Equatable {
    let id: Int
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

extension MovieItem {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: APIEndpoints.posterImageBaseUrl + posterPath)
    }

}

extension MovieItem {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
       }()
    
    var releaseDateAsDate : Date? {
        guard let releaseDate = releaseDate else { return nil }
        return MovieItem.dateFormatter.date(from: releaseDate)
    }
    
    var releaseYear : String? {
        guard let date = releaseDateAsDate else { return nil }
        return date.formatted(.dateTime.year())
    }

}
