//
//  ErrorView.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var photoFetcher: PhotoFetcher
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🚫")
                .font(.system(size: 80))
            Text(photoFetcher.errorMessage ?? "")
            
            Button {
                
            } label: {
                Text("Try again")
            }
            .accessibilityIdentifier("tryAgainButton")
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(photoFetcher: PhotoFetcher(fetchType: .recentPhotos))
    }
}
