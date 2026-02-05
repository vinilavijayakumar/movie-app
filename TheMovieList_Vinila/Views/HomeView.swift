//
//  HomeView.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: MovieListViewModel
    @State private var showFilters = false
    

    private var refreshButton: some View {
        Button {
            Task { try await viewModel.refreshView() }
        } label: {
            Image(systemName: "arrow.clockwise")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .clipShape(Circle())
                .shadow(radius: 6)
        }
        .padding()
    }

    
    var body: some View {
        ZStack {
            List(viewModel.filteredList.isEmpty && viewModel.searchString.isEmpty
                 ? viewModel.list
                 : viewModel.filteredList)
            { movieItem in
                MovieCardView(movieItem: movieItem)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
                    .listRowBackground(Color.clear)
                    .onAppear {
                        if movieItem.id == viewModel.list.last?.id {
                            Task {
                                try await viewModel.fetchNextPageIfNeeded()
                            }
                        }
                    }
                    .listStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        Section {
            EmptyView()
        } footer: {
            Text(viewModel.hasReachedEnd ? "End of results" : "Loading more…")
                .foregroundColor(.secondary)
               // .padding()
                .frame(height: 20)
        }
        .navigationTitle("Movie List")
        .searchable(text: $viewModel.searchString,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search by title")
        .onChange(of: viewModel.searchString) {
            viewModel.applyFilters()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showFilters.toggle()
                } label: {
                    Image(systemName: viewModel.filter.isActive
                          ? "line.3.horizontal.decrease.circle.fill"
                          : "line.3.horizontal.decrease.circle")
                }
            }
        }

       .overlay(alignment: .bottomTrailing) {
           refreshButton
       }
        
       .sheet(isPresented: $showFilters) {
           FilterSheetView(viewModel: viewModel)
               .presentationDetents([.medium])
       }
        
        
    }
    
}

#Preview {
    HomeView(viewModel: MovieListViewModel())
}


