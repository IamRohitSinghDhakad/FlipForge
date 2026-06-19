//
//  ImagePickerSource.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine


enum ImagePickerSource {

    case camera
    case photoLibrary
}


@MainActor
final class ImagePickerManager: ObservableObject {

    @Published var selectedImage: UIImage?
}


struct CustomImagePicker: View {

    @Binding var selectedImage: UIImage?

    @State private var selectedItem: PhotosPickerItem?

    var body: some View {

        PhotosPicker(
            selection: $selectedItem,
            matching: .images
        ) {

            contentView
        }
        .onChange(of: selectedItem) { _, newItem in

            Task {

                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {

                    selectedImage = image
                }
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {

        if let image = selectedImage {

            Image(uiImage: image)
                .resizable()
                .scaledToFill()

        } else {

            Image(systemName: "camera.fill")
                .font(.system(size: 70))
                .foregroundColor(.white)
        }
    }
}

