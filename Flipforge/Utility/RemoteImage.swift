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

    var body: some View {

        Group {

            if isCircle {

                AsyncImage(url: URL(string: url ?? "")) { phase in

                    switch phase {

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    default:
                        Image(placeholder)
                            .resizable()
                            .scaledToFill()
                    }

                }
                .frame(width: width, height: height)
                .clipShape(Circle())

            } else {

                AsyncImage(url: URL(string: url ?? "")) { phase in

                    switch phase {

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    default:
                        Image(placeholder)
                            .resizable()
                            .scaledToFill()
                    }

                }
                .frame(width: width, height: height)
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadius)
                )

            }
        }
    }
}
