//
//  MovieCardView.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import SwiftUI

struct MovieCardView : View {
    var movieItem : MovieItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: movieItem.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 450)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(movieItem.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(movieItem.overview ?? "Overview")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(4)
            Text("Release date: \(movieItem.releaseDate ?? "-")")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .bold()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(
                    color: Color.black.opacity(0.20),
                    radius: 10,
                    x: 0,
                    y: 2
                )
        }
    }
}
