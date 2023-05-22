//
//  PhotosessionListViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 02.05.2023.
//

import Foundation
import Combine

protocol PhotosessionListViewModelIO: ObservableObject {
    func showTabBar()
    func openPhotosessionCreation()
    var shownPhotosessions: [PhotosessionListItem] { get }
    var photosessionList: [PhotosessionListItem] { get }
    var photoSessionTypeSelection: Int {get set}
    func openChat(url: String)
    func openPhotosession(id: String)
    func acceptInvite(id: String)
    func declineInvite(id: String)
}

class PhotosessionListViewModel<coordinator: PhotoSessionModuleFlowCoordintorIO>: ViewModelProtocol, PhotosessionListViewModelIO {
    
    internal init(output: coordinator, photoService: PhotosessionService) {
        self.moduleOutput = output
        self.photoService = photoService
        self.loadPhotosessions()
    }
    
    let moduleOutput: coordinator
    let photoService: PhotosessionService
    var photosessionList: [PhotosessionListItem] = []
    
    var shownPhotosessions: [PhotosessionListItem] {
        if photoSessionTypeSelection == 0 {
            return photosessionList
        }
        if photoSessionTypeSelection == 1 {
            return photosessionList.filter({ item in item.photosessionStatus == .ready})
        }
        if photoSessionTypeSelection == 2 {
            return photosessionList.filter({ item in item.photosessionStatus == .refusal})
        }
        else {
            return photosessionList.filter({ item in item.photosessionStatus == .expectation})
        }
    }
    
    @Published var photoSessionTypeSelection = 0
    @Published var refresh = 0
    var bag: [AnyCancellable] = []
    
    func loadPhotosessions() {
        photoService.getAllPhotosessionsPublisher().sink(receiveCompletion: { res in
            self.checkComplition(res: res)
        }, receiveValue: { response in
            if response.statusCode > 299 {
                self.showResponseError(response: response)
            } else {
                do {
                    let photosessions = try JSONDecoder().decode(AllPhotosessionsUserInfo.self, from: response.data)
                    self.photosessionList = photosessions.photosessions
                } catch {
                    print(error)
                    self.moduleOutput.showAlert(error: .decodingError)
                }
            }
        }).store(in: &bag)
    }
    
    func openPhotosessionCreation() {
        moduleOutput.openPhotosessionCreation(passCreatedPhotosession: openPhotosession)
    }
    
    func openPhotosession(id: String) {
        photoService.getPhotosesionPublisher(id: id).sink(receiveCompletion: { res in
            self.checkComplition(res: res)
        }, receiveValue: { response in
            if response.statusCode > 299 {
                self.showResponseError(response: response)
            } else {
                do {
                    let info = try JSONDecoder().decode(PhotosessionFullInfo.self, from: response.data)
                    self.addPhotosession(info: info)
                    self.moduleOutput.openPhotosession(info: info)
                } catch {
                    print(error)
                    self.moduleOutput.showAlert(error: .decodingError)
                }
            }
        }).store(in: &bag)
    }
    
    func addPhotosession(info: PhotosessionFullInfo) {
        if !photosessionList.contains(where: { item in item.id.elementsEqual(info.id)}) {
            self.photosessionList.append( (PhotosessionListItem(id: info.id, name: info.name,
                                                                address: info.address,
                                                                start_time: info.start_date_and_time,
                                                                end_time: info.end_date_and_time,
                                                                participants_avatars: [],
                                                                photosessionStatus: .expectation,
                                                                chat_url: info.chat_url)))
        }
    }
    
    func acceptInvite(id: String) {
        let index = photosessionList.firstIndex(where: {item in item.id == id})
        photosessionList[index!].photosessionStatus = .ready
        refresh+=1
    }
    
    func declineInvite(id: String) {
        let index = photosessionList.firstIndex(where: {item in item.id == id})
        photosessionList.remove(at: index!)
        refresh+=1
    }
    
    func showTabBar() {
        moduleOutput.showTabBar()
    }
    
    func openChat(url: String) {
        moduleOutput.openChat(url: url)
    }
}
