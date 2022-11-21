//
//  PhotoDetailView.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import SwiftUI
import CachedAsyncImage

struct PhotoDetailView: View {
    @State private var photoListType: PhotoListType
    
    let photo: Photo
    let imageSize: CGFloat = 200
    let profileImageSize: CGFloat = 48
    
    init(photo: Photo, photoListType: PhotoListType) {
        self.photo = photo
        self.photoListType = photoListType
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: ContentView(photoListType: .userPhotos, user: photo.user)) {
                HStack {
                    if let userProfileImageURL = photo.user?.profileImageURL, let iconServer = photo.user?.iconserver {
                        if Int(iconServer) ?? 0 > 0 {
                            CachedAsyncImage(url: userProfileImageURL)
                                .frame(maxWidth: profileImageSize, maxHeight: profileImageSize)
                                .cornerRadius(profileImageSize * profileImageSize / 2)
                                .overlay(
                                RoundedRectangle(cornerRadius: profileImageSize * profileImageSize / 2)
                                    .stroke(.gray, lineWidth: 0.5)
                                )
                        }
                        else {
                            CachedAsyncImage(url: URL(string: "https://www.flickr.com/images/buddyicon.gif"))
                                .frame(maxWidth: profileImageSize, maxHeight: profileImageSize)
                                .cornerRadius(profileImageSize * profileImageSize / 2)
                                .overlay(
                                RoundedRectangle(cornerRadius: profileImageSize * profileImageSize / 2)
                                    .stroke(.gray, lineWidth: 0.5)
                                )
                        }
                    }
                    VStack {
                        if let user = photo.user {
                            if let realname = user.realname?._content, !realname.isEmpty {
                                Text(realname)
                                    .bold()
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text(user.id)
                                    .bold()
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            if let photoInfo = photo.info {
                                Text(photoInfo.dates.taken)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            .foregroundColor(.black)
            .disabled(photoListType == .userPhotos)
            VStack {
                CachedAsyncImage(url: photo.imageURL)
                ScrollView {
                    if let info = photo.info {
                        Text(photo.title)
                            .padding()
                            .bold()
                        if let description = info.description._content {
                            Text(description)
                                .padding()
                        }
                        Text("Date Taken: \(info.dates.taken)")
                            .bold()
                    }
                }
            }
        }
        .padding()
    }
}
