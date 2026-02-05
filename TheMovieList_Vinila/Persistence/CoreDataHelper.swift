//
//  CoreDataHelper.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//


import CoreData

class CoreDataHelper {
    
    static let context = PersistenceController.shared.container.viewContext
    static let request: NSFetchRequest<MovieItemEntity> = {
           let request = NSFetchRequest<MovieItemEntity>(entityName: "MovieItemEntity")
           return request
       }()
    
    func saveMoviesToCoreData(_ movies: [MovieItem]) {
        
        for movie in movies {
            
            CoreDataHelper.request.predicate = NSPredicate(format: "id == %d", movie.id)
            CoreDataHelper.request.fetchLimit = 1
           
            let existing = try? CoreDataHelper.context.fetch(CoreDataHelper.request)
            if existing?.first != nil {
               continue // skip duplicates
            }
            
            
            let entity = MovieItemEntity(context: CoreDataHelper.context)
            entity.id = Int64(movie.id)
            entity.title = movie.title
            entity.overView = movie.overview
            entity.posterUrl = movie.posterURL?.absoluteString
            entity.releaseDateStr = movie.releaseDate
            entity.releaseYear = movie.releaseYear
        }
        
        do {
            try CoreDataHelper.context.save()
            print("Movies saved to Core Data")
        } catch {
            print("Failed to save movies: \(error)")
        }
    }
    
    func fetchMoviesFromCoreData() -> [MovieItem] {
        do {
            let entities = try CoreDataHelper.context.fetch(CoreDataHelper.request)
            
            let list = entities.map { entity in
                MovieItem(id: Int(entity.id),
                          overview: entity.overView,
                          posterPath: entity.posterUrl,
                          releaseDate: entity.releaseDateStr,
                          title: entity.title ?? "title")
                
            }
            return list
          
        } catch {
            print("Failed to load movies from Core Data: \(error)")
           return []
        }
    }


}
