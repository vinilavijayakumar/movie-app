//
//  MovieListView.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import SwiftUI

struct MovieListView : View {
    
    @StateObject private var viewModel = MovieListViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationStack {
            VStack{
                switch self.viewModel.fetchStatus{
                    
                case .notStarted:
                    ProgressView("Loading Movies..")
                    
                case .isLoaded:
                    HomeView(viewModel: viewModel)
                    
                case .failed(underlyingError: let error):
                    Text(error.localizedDescription)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                viewModel.loadFromCoreData()
                do {
                    try await viewModel.fetchInitialList()
                }catch {
                    alertMessage = "Could not load movie list"
                }
            }
            .alert("Alert", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}


#Preview {
    MovieListView()
}



