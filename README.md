# movie-app
iOS app to list movies from TDMB


Features
- List items with pagination
- Search with movie title, release year and release date range
- Offline caching using coredata
- Clean MVVM architecture with views, viewmodels, datamodels and workers in seperate folders for easy understanding

---

## 🛠 Tech Stack
- Language: Swift 5
- UI: SwiftUI
- Architecture: MVVM
- Networking: URLSession
- Persistence: CoreData

---

API used
TDMB free movie listing api with my API key is used to fetch the movie list. 
The specific api used is the Popular Movies: https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY
As the api doesnot mention the actual no:of pages, i have set a max number of pages allowed and set it to 10 to avoid indefinite loading.
The loading more and end of results is shown below the list along with a refresh button that refreshed all the list.
All other options and the api key along with base url to fetch poster images in mentioned in the file called EndPoints inside constants folder.

Persistence is implemented using coredata. The list once fetched from the api is stored in coredata without duplication. And if coredata list is available, that is loaded first to increase user experience. 

Filtering can be done using three criteria. 

Real time messaging is not included as without a backend i cant reliably send firebase push notifications for new TMDB movies. TMDB doesnot provide any api or webhook for the same as per my research. I can fetch the list at the start of the app launch and compare the ids with the ones in coredata to understand if there are new movies and show a local notification, but this will still be done on app launch and not in background which makes the purpose of notification meaningless. Also as per the code, coredata is populated only as the api fetch is made for each new page as user scrolls. if the user doesnt scroll to page 4, the page 4 movies will not be fetched and hence saved in coredata as of now. This was done so to avoid unnecessary network usage.

The app is available in potrait mode. upside down and landscape is unchecked for aesthetic purpose. No third party sdk is used in the app. Hence no use of SPM or Cocoapods. A mock AppIcon is provided for aesthetic purposes. 
