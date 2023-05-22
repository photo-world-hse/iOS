//
//  PhotosessionViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 18.05.2023.
//

import Foundation

protocol PhotosessionViewModelIO: ObservableObject {
    var photosession: PhotosessionFullInfo {get}
    func filterParticipants(index: Int) -> [ParticipantInfo]
    func refreshView()
    func finishPhotosession()
    func openChat()
    func inviteUsers()
    func openImages()
}

class PhotosessionViewModel<coordinator: PhotoSessionModuleFlowCoordintorIO>:
                                        ViewModelProtocol, PhotosessionViewModelIO {
    
    internal init(moduleOutput: coordinator,
                  photosession: PhotosessionFullInfo) {
        self.moduleOutput = moduleOutput
        self.photosession = photosession
    }
    
    let moduleOutput: coordinator
    @Published var photosession: PhotosessionFullInfo
    @Published var participantTypeIndex = 0
    @Published var refresh: Bool = false
    
    func filterParticipants(index: Int) -> [ParticipantInfo] {
        if let participants = photosession.participants {
            switch index {
            case 0:
                return participants
            case 1:
                return participants.filter({ info in info.profile_type == .stylist })
            case 2:
                return participants.filter({ info in info.profile_type == .model })
            default:
                return participants.filter({ info in info.profile_type == .photographer })
            }
        } else {
            return []
        }
    }
    
    func finishPhotosession() {
        moduleOutput.finishPhotosession(id: photosession.id, participants: photosession.participants!)
    }
    
    func openChat() {
        
    }
    
    func inviteUsers() {
        moduleOutput.addParticipants(inviteParticipant: { profile in
            let participant = ParticipantInfo(name: profile.name,
                                              email: profile.email,
                                              avatar_url: profile.avatar_url,
                                              profile_type: ProfileType.photographer,
                                              rating: profile.rating,
                                              comments_number: profile.comments_number,
                                              invite_status: .pending)
            if let _ = self.photosession.participants {
                self.photosession.participants?.append(participant)
            } else {
                self.photosession.participants = [participant]
            }
        })
    }
    
    func refreshView() {
        refresh.toggle()
    }
    
    func openImages() {
        moduleOutput.openImagesViewer(urls: photosession.photos ?? [])
    }
}
