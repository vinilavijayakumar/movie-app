//
//  FilterSheetView.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 05/02/2026.
//

import SwiftUI

struct FilterSheetView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {

                // YEAR
                Section("Year") {
                    Picker("Release Year", selection: $viewModel.filter.year) {
                        Text("All Years").tag(String?.none)
                        ForEach(viewModel.availableYears, id: \.self) {
                            Text($0).tag(String?.some($0))
                        }
                    }
                }

                // DATE RANGE
                Section("Release Date Range") {
                    DatePicker(
                        "From",
                        selection: Binding(
                            get: { viewModel.filter.startDate ?? Date() },
                            set: { viewModel.filter.startDate = $0 }
                        ),
                        displayedComponents: .date
                    )

                    DatePicker(
                        "To",
                        selection: Binding(
                            get: { viewModel.filter.endDate ?? Date() },
                            set: { viewModel.filter.endDate = $0 }
                        ),
                        displayedComponents: .date
                    )
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear") {
                        viewModel.resetFilters()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Apply") {
                        viewModel.applyFilters()
                        dismiss()
                    }
                }
            }
        }
    }
}
