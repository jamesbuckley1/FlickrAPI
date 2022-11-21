//
//  LoadingView.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("📷")
                .font(.system(size: 80))
            ProgressView()
            Text("Loading Photos")
                .foregroundColor(.gray)
        }
    }
}
