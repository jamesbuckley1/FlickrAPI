//
//  PhotoListView.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import SwiftUI

struct PhotoListView: View {
    @State private var searchText: String = ""
    @State private var photoListType: PhotoListType
    
    let photos: [Photo]
    
    init(photos: [Photo], photoListType: PhotoListType? = nil) {
        self.photos = photos
        if let listType = photoListType {
            self.photoListType = listType
        }
        else {
            self.photoListType = .recentPhotos
        }
    }
    
    var filteredPhotos: [Photo] {
        if searchText.count == 0 {
            return photos
        } else {
            return photos.filter { photo in
                let tagContents = photo.info?.tags.tagContent.filter{ $0._content.lowercased().hasPrefix(searchText.lowercased()) } ?? []
                
                return !tagContents.isEmpty
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if filteredPhotos.count > 0 {
                    ForEach(filteredPhotos) { photo in
                        NavigationLink {
                            PhotoDetailView(photo: photo, photoListType: photoListType)
                        } label: {
                            PhotoRow(photo: photo, photoListType: photoListType)
                        }
                    }
                } else {
                    Text("There are no photos to show.")
                }
            }
            .navigationTitle(photoListType.rawValue)
            .searchable(text: $searchText)
        }
    }
}
