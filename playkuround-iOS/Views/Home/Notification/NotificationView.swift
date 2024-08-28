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
    
    // 임시 구현 (추후 API 연결 시 HomeViewModel로 이동 예정)
    struct Notification {
        let title: String
        let text: String?
        let imageURL: String?
        let linkURL: String?
    }
    
    enum NotificationType {
        case textOnly
        case imageOnly
        case textAndImage
    }
    
    let notis: [Notification] = [Notification(title: "녹색지대 부스 안내",
                                              text: "5/22~24 (수,목) 녹색지대 플레이쿠라운드 팝업스토어 운영",
                                              imageURL: "https://shorturl.at/6hQj6",
                                              linkURL: "https://www.instagram.com/p/C7LuzJehez-/?utm_source=ig_web_copy_link"),
                                 Notification(title: "녹색지대 부스 안내",
                                              text: nil,
                                              imageURL: "https://shorturl.at/6hQj6",
                                              linkURL: "https://www.instagram.com/p/C7LuzJehez-/?utm_source=ig_web_copy_link"),
                                 Notification(title: "녹색지대 부스 안내",
                                              text: "5/22~24 (수,목) 녹색지대 플레이쿠라운드 팝업스토어 운영",
                                              imageURL: nil,
                                              linkURL: "https://www.instagram.com/p/C7LuzJehez-/?utm_source=ig_web_copy_link")]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    homeViewModel.transition(to: .home)
                }
            
            if let notiType = getNotificationType(index) {
                Image(notiType == .textOnly ? .notiShortBackground : .notiLongBackground)
                    .overlay {
                        HStack(spacing: 12) {
                            Button {
                                index = max(index - 1, 0)
                                soundManager.playSound(sound: .buttonClicked)
                            } label: {
                                Image(.storyLeftArrow)
                            }
                            .opacity(index != 0 ? 1 : 0)
                            
                            VStack(spacing: 0) {
                                Text(notis[index].title)
                                    .font(.neo20)
                                    .foregroundColor(.kuText)
                                    .kerning(-0.41)
                                    .padding(.bottom, 16)
                                
                                // 사진 텍스트 둘 다
                                if notiType == .textAndImage, let notiImageURLString = notis[index].imageURL {
                                    AsyncImage(url: URL(string: notiImageURLString)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 210, height: 180)
                                    } placeholder: {
                                        LoadingImage(loadingColor: .black)
                                            .frame(width: 210, height: 180)
                                    }
                                    .padding(.bottom, 20)
                                }
                                
                                // 사진만
                                else if notiType == .imageOnly, let notiImageURLString = notis[index].imageURL {
                                    AsyncImage(url: URL(string: notiImageURLString)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 210, height: 250)
                                    } placeholder: {
                                        LoadingImage(loadingColor: .black)
                                            .frame(width: 210, height: 250)
                                    }
                                    .padding(.bottom, 20)
                                }
                                
                                if notiType != .imageOnly, let notiText = notis[index].text {
                                    ScrollView {
                                        VStack {
                                            Text(notiText)
                                                .font(.pretendard15R)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .frame(height: 54)
                                    .padding(.bottom, 20)
                                }
                                
                                Button {
                                    // TODO: 링크 열기
                                    soundManager.playSound(sound: .buttonClicked)
                                } label: {
                                    if notis[index].linkURL != nil {
                                        Image(.smallButtonBlue)
                                            .overlay {
                                                Text("Notification.Link")
                                                    .font(.neo18)
                                                    .foregroundStyle(.kuText)
                                                    .kerning(-0.41)
                                            }
                                    } else {
                                        Image(.smallButtonBlue).opacity(0)
                                    }
                                }
                                .padding(.bottom, 20)
                                
                                HStack {
                                    ForEach(Array(notis.enumerated()), id: \.offset) { offset, noti in
                                        if offset == index {
                                            Button {
                                                self.index = offset
                                                soundManager.playSound(sound: .buttonClicked)
                                            } label: {
                                                Image(.nowStoryBlock)
                                            }
                                        } else {
                                            Button {
                                                self.index = offset
                                                soundManager.playSound(sound: .buttonClicked)
                                            } label: {
                                                Image(.previewStoryBlock)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: 210)
                            
                            Button {
                                index = min(index + 1, notis.count - 1)
                                soundManager.playSound(sound: .buttonClicked)
                            } label: {
                                Image(.storyRightArrow)
                            }
                            .opacity(index != notis.count - 1 ? 1 : 0)
                        }
                    }
            }
        }
    }
    
    func getNotificationType(_ index: Int) -> NotificationType? {
        if notis[index].imageURL == nil && notis[index].text != nil {
            return .textOnly
        }
        // 사진만 있는 경우
        else if notis[index].imageURL != nil && notis[index].text == nil {
            return .imageOnly
        }
        // 둘 다 있는 경우
        else if notis[index].text != nil && notis[index].imageURL != nil {
            return .textAndImage
        }
        // 예외
        else {
            return nil
        }
    }
}
