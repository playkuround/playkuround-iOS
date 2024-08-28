//
//  NotificationView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/25/24.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    private let soundManager = SoundManager.shared
    
    @State private var index = 0
    
    enum NotificationType {
        case textOnly
        case imageOnly
        case textAndImage
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    homeViewModel.transition(to: .home)
                }
            
            if let event = homeViewModel.getEventByIndex(index) {
                
                if let notiType = getNotificationType(index) {
                    Image(notiType == .textOnly ? .notiShortBackground : .notiLongBackground)
                        .overlay {
                            HStack(spacing: 12) {
                                Button {
                                    // 조회 처리
                                    homeViewModel.viewEvent(id: event.id)
                                    index = max(index - 1, 0)
                                    soundManager.playSound(sound: .buttonClicked)
                                } label: {
                                    Image(.storyLeftArrow)
                                }
                                .opacity(index != 0 ? 1 : 0)
                                
                                let isNew = self.isNew(event.id)
                                
                                VStack(spacing: 0) {
                                    HStack {
                                        if isNew {
                                            Spacer()
                                                .frame(width: 33)
                                        }
                                        
                                        Text(event.title)
                                            .font(.neo20)
                                            .foregroundColor(.kuText)
                                            .kerning(-0.41)
                                        
                                        if isNew {
                                            Text("Home.Badge.New")
                                                .font(.neo15)
                                                .foregroundColor(.kuTimebarRed)
                                                .kerning(-0.41)
                                        }
                                    }
                                    .padding(.top, 50)
                                    .padding(.bottom, 16)
                                    .padding(.horizontal, -40)
                                    
                                    // 사진 텍스트 둘 다
                                    if notiType == .textAndImage, let notiImageURLString = event.imageUrl {
                                        VStack(spacing: 0) {
                                            Spacer()
                                            AsyncImage(url: URL(string: notiImageURLString)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 210)
                                            } placeholder: {
                                                LoadingImage(loadingColor: .black)
                                                    .frame(width: 210)
                                            }
                                            Spacer()
                                        }
                                        .padding(.bottom, 20)
                                    }
                                    
                                    // 사진만
                                    else if notiType == .imageOnly, let notiImageURLString = event.imageUrl {
                                        VStack(spacing: 0) {
                                            Spacer()
                                            AsyncImage(url: URL(string: notiImageURLString)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 210)
                                            } placeholder: {
                                                LoadingImage(loadingColor: .black)
                                                    .frame(width: 210)
                                            }
                                            Spacer()
                                        }
                                        .padding(.bottom, 20)
                                    }
                                    
                                    if notiType != .imageOnly, let notiText = event.description {
                                        ScrollView {
                                            VStack(alignment: .center) {
                                                Text(notiText)
                                                    .font(.pretendard15R)
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .frame(height: (notiType == .textOnly && event.referenceUrl == nil) ? 120 : 54)
                                        .padding(.bottom, 20)
                                    }
                                    
                                    if let referenceURL = event.referenceUrl {
                                        Button {
                                            openEventLink(referenceURL)
                                            soundManager.playSound(sound: .buttonClicked)
                                        } label: {
                                            Image(.smallButtonBlue)
                                                .overlay {
                                                    Text("Notification.Link")
                                                        .font(.neo18)
                                                        .foregroundStyle(.kuText)
                                                        .kerning(-0.41)
                                                }
                                        }
                                        .padding(.bottom, 20)
                                    }
                                    
                                    HStack {
                                        ForEach(Array(homeViewModel.eventList.enumerated()), id: \.offset) { offset, noti in
                                            Button {
                                                // 조회 처리
                                                homeViewModel.viewEvent(id: event.id)
                                                self.index = offset
                                                soundManager.playSound(sound: .buttonClicked)
                                            } label: {
                                                Image(offset == index ?
                                                    .nowStoryBlock : .previewStoryBlock)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 42)
                                }
                                .frame(width: 210)
                                
                                Button {
                                    // 조회 처리
                                    homeViewModel.viewEvent(id: event.id)
                                    index = min(index + 1, homeViewModel.eventList.count - 1)
                                    soundManager.playSound(sound: .buttonClicked)
                                } label: {
                                    Image(.storyRightArrow)
                                }
                                .opacity(index != homeViewModel.eventList.count - 1 ? 1 : 0)
                            }
                        }
                        .onDisappear {
                            // 조회 처리
                            homeViewModel.viewEvent(id: event.id)
                            homeViewModel.updateIsNewEvent()
                        }
                }
            }
        }
    }
    
    func getNotificationType(_ index: Int) -> NotificationType? {
        if let event = homeViewModel.getEventByIndex(index) {
            if event.imageUrl == nil && event.description != nil {
                return .textOnly
            }
            // 사진만 있는 경우
            else if event.imageUrl != nil && event.description == nil {
                return .imageOnly
            }
            // 둘 다 있는 경우
            else if event.description != nil && event.imageUrl != nil {
                return .textAndImage
            }
            
        }
        
        return nil
    }
    
    func isNew(_ index: Int) -> Bool {
        let topID = EventManager.shared.getTopEventID()
        print("isNew - topID: \(topID), currID: \(index)")
        return index > topID
    }
    
    private func openEventLink(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    NotificationView(homeViewModel: HomeViewModel(rootViewModel: RootViewModel()))
}
