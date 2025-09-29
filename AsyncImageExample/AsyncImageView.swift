//
//  Project: AsyncImageView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger
    

import SwiftUI

// Main view for displaying asynchronously loaded images
struct AsyncImageView: View {
    // Array of image URLs from picsum.photos service
    // compactMap is used to safely convert strings to URLs
    let imageURLs = [
        "https://picsum.photos/id/127/300",
        "https://picsum.photos/id/100/300",
        "https://picsum.photos/id/10/300",
        "https://picsum.photos/id/9/300"
    ].compactMap(URL.init)
    
    var body: some View {
        // ScrollView to allow scrolling through multiple images
        ScrollView{
            VStack{
                // Iterate through each URL and create an AsyncImage
                ForEach(imageURLs, id: \.self){ url in
                    AsyncImage(url: url){
                        phase in
                        // Handle different states of image loading
                        switch phase {
                        case .empty:
                            ProgressView() // Loading state - shows spinner
                        case .success(let image):
                            // Successfully loaded image
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300,height: 300)
                                .cornerRadius(25)
                        case .failure:
                            // Error state - shows warning triangle
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height: 100)
                                .cornerRadius(25)
                                .foregroundStyle(.red)
                        @unknown default:
                            // Handle any future cases
                            EmptyView()
                        }
                    }
                }
                
                .frame(width: 300, height: 300)
                
                // Descriptive text below the images
                Text("Random image from Picsum.photos")
                    .font(.headline)
                
            }
        }
        .padding()
    }
}

// Preview provider for SwiftUI canvas
#Preview {
    AsyncImageView()
}
