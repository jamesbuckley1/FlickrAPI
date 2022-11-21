//
//  ContentView.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject var photoFetcher: PhotoFetcher
    @State private var photoListType: PhotoListType = .recentPhotos
    
    init(photoListType: PhotoListType? = nil, user: User? = nil) {
        if let photoListType = photoListType {
            self.photoListType = photoListType
            _photoFetcher = StateObject(wrappedValue: PhotoFetcher(fetchType: photoListType, user: user))
        } else {
            _photoFetcher = StateObject(wrappedValue: PhotoFetcher(fetchType: .recentPhotos))
        }
    }
    
    var body: some View {
        if photoFetcher.isLoading {
            LoadingView()
        } else if photoFetcher.errorMessage != nil {
            ErrorView(photoFetcher: photoFetcher)
        } else {
            PhotoListView(photos: photoFetcher.photos, photoListType: photoListType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
