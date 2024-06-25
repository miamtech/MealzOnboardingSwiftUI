//
//  AsyncImage.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 14, *)
class ImageLoader: ObservableObject {
    @Published public var image: Image?
    private var cancellable: AnyCancellable?

    func load(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {
                if let uiImage = UIImage(data: $0.data) {
                    return Image(uiImage: uiImage)
                } else {
                    return nil
                }
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0  }
    }

    func cancel() {
        cancellable?.cancel()
    }
}

@available(iOS 14, *)
public struct AsyncImage<Content>: View where Content: View {
    public let url: URL
    @ViewBuilder public let contentProvider: (Image) -> Content
    @StateObject private var imageLoader: ImageLoader = ImageLoader()

    public init(url: URL, contentProvider: @escaping (Image) -> Content) {
        self.url = url
        self.contentProvider = contentProvider
    }

    public var body: some View {
        HStack(spacing: 0) {
            if let image = imageLoader.image {
                contentProvider(image)
            } else {
                    // Placeholder view?
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            imageLoader.load(url: url)
        }
        .onDisappear {
            imageLoader.cancel()
        }
    }
}
