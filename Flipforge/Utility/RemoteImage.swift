//
//  RemoteImage.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation
import SwiftUI
import Combine

struct RemoteImage: View {

    let url: String?
    let placeholder: String

    let width: CGFloat
    let height: CGFloat

    var isCircle = false
    var cornerRadius: CGFloat = 12

    private var imageURL: URL? {
        guard let url,
              !url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let validURL = URL(string: url)
        else {
            return nil
        }

        return validURL
    }

    var body: some View {

        AsyncImage(url: imageURL) { phase in

            switch phase {

            case .success(let image):

                image
                    .resizable()
                    .scaledToFill()

            case .empty, .failure:

                placeholderImage

            @unknown default:

                placeholderImage
            }
        }
        .frame(
            width: width,
            height: height
        )
        .clipShape(
            isCircle
            ? AnyShape(Circle())
            : AnyShape(
                RoundedRectangle(
                    cornerRadius: cornerRadius
                )
            )
        )
    }

    private var placeholderImage: some View {

        Image(placeholder)
            .resizable()
            .scaledToFill()
    }
}
