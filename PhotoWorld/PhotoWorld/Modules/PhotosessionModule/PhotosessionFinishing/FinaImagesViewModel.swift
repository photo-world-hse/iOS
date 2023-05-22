//
//  FinaImagesViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 16.05.2023.
//

import Foundation
import Moya
import Combine

protocol FinalImagesViewModelIO: ObservableObject {
    var urls: [URL] { get }
    var imageLoader: ImageLoader { get }
    func goToCommentView()
}

class FinalImagesViewModel<coordinator: PhotosessionFinishFlowCoordinatorIO>: ViewModelProtocol, FinalImagesViewModelIO {
    internal init(moduleOutput: coordinator,
                  photosessionID: String,
                  photosessionService: PhotosessionService,
                  imagesService: ImagesService) {
        self.moduleOutput = moduleOutput
        self.photosessionService = photosessionService
        self.imagesService = imagesService
        self.photosessionID = photosessionID
        
        loadResultPhotos()
    }
    
    let moduleOutput: coordinator
    let photosessionService: PhotosessionService
    let imagesService: ImagesService
    lazy var imageLoader: ImageLoader = ImageLoader(imageService: imagesService, passImageURLs: self.photosLoaded)
    @Published var urls: [URL] = []
    let photosessionID: String
    var bag: [AnyCancellable] = []
    
    func loadResultPhotos() {
        photosessionService.getResultPhotosPublisher(id: photosessionID).sink(receiveCompletion: { res in
            self.checkComplition(res: res)
        }, receiveValue: { response in
            if response.statusCode > 299 {
                self.showResponseError(response: response)
            } else {
                do {
                    let photos = try JSONDecoder().decode(PhotosessionPhotos.self, from: response.data)
                    self.urls.append(contentsOf: photos.photos)
                } catch {
                    self.moduleOutput.showAlert(error: .decodingError)
                }
            }
        }).store(in: &bag)
        
    }
    
    func photosLoaded(urls: [URL]) {
        photosessionService.addResultsPhotosPublisher(id: photosessionID, photos: urls)
            .sink(receiveCompletion: { res in
            self.checkComplition(res: res)
        }, receiveValue: { response in
            if response.statusCode > 299 {
                self.showResponseError(response: response)
            } else {
                self.urls.append(contentsOf: urls)
            }
        }).store(in: &bag)
    }
    
    func goToCommentView() {
        self.moduleOutput.openParticipantsCommentsView()
    }
}
