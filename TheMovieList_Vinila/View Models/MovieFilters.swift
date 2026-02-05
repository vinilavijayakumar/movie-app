//
//  MovieFilters.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 05/02/2026.
//

import Foundation

struct MovieFilter {
    var year: String? = nil
    var startDate: Date? = nil
    var endDate: Date? = nil

    var isActive: Bool {
        year != nil || startDate != nil || endDate != nil
    }
}
