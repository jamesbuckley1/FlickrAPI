//
//  PhotoRow.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import SwiftUI
import CachedAsyncImage

struct PhotoRow: View {
    @State var selection: Int? = nil
    @State var photoListType: PhotoListType
    
    let photo: Photo
    let imageSize: CGFloat = 200
    let profileImageSize: CGFloat = 48
    
    init(photo: Photo, photoListType: PhotoListType) {
        self.photo = photo
        self.photoListType = photoListType
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: ContentView(photoListType: .userPhotos, user: photo.user), tag: 1, selection: $selection) {
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
                        }
                        if let photoInfo = photo.info {
                       
                            Text(photoInfo.dates.taken)
                                .font(.caption)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .onTapGesture {
                    self.selection = 1
                }
                .disabled(photoListType == .userPhotos)
            }
            Text(photo.title)
                .font(.headline)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            CachedAsyncImage(url: photo.imageURL) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFit()
                        .clipped()
                } else if phase.error != nil {
                    Text(phase.error?.localizedDescription ?? "Error")
                        .foregroundColor(Color.red)
                        .frame(width: imageSize, height: imageSize)
                } else {
                    ProgressView()
                        .frame(width: imageSize, height: imageSize)
                }
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(5)
            .padding()
            
            if let info = photo.info {
                WrappingHStack(models: info.tags.tagContent) { tag in
                    Text(tag._content)
                        .padding(5)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.caption)
                        .cornerRadius(5)
                }
            }
        }
        .onDisappear {
            self.selection = 0
        }
    }
}

//struct PhotoRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoRow()
//    }
//}
