//
//  NotificationView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/25/24.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var index = 0
    
    // 임시 구현
    struct Notification {
        let title: String
        let text: String?
        let imageURL: String?
        let linkURL: String?
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
            
            // 텍스트만 있는 경우
            if notis[index].imageURL == nil && notis[index].text != nil {
                if let notiText = notis[index].text {
                    Image(.notiShortBackground)
                        .overlay {
                            
                        }
                }
            }
            // 사진만 있는 경우
            else if notis[index].imageURL != nil && notis[index].text == nil {
                if let notiImageURLString = notis[index].imageURL {
                    Image(.notiLongBackground)
                        .overlay {
                            
                        }
                }            }
            // 둘 다 있는 경우
            else if let notiText = notis[index].text, let notiImageURLString = notis[index].imageURL {
                Image(.notiLongBackground)
                    .overlay {
                        HStack(spacing: 12) {
                            Button {
                                index = max(index - 1, 0)
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
                                
                                Button {
                                    // TODO: 링크 열기
                                } label: {
                                    Image(.smallButtonBlue)
                                        .overlay {
                                            Text("링크")
                                                .font(.neo18)
                                                .foregroundStyle(.kuText)
                                                .kerning(-0.41)
                                        }
                                }
                                .padding(.bottom, 20)
                                
                                HStack {
                                    ForEach(Array(notis.enumerated()), id: \.offset) { offset, noti in
                                        if offset == index {
                                            Button {
                                                
                                            } label: {
                                                Image(.nowStoryBlock)
                                            }
                                        } else {
                                            Button {
                                                
                                            } label: {
                                                Image(.previewStoryBlock)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: 210)
                            .border(.black)
                            
                            Button {
                                index = min(index + 1, notis.count - 1)
                            } label: {
                                Image(.storyRightArrow)
                            }
                            .opacity(index != notis.count - 1 ? 1 : 0)
                        }
                        .border(.red)
                    }
            }
        }
    }
    
    enum NotificationType {
        case textOnly
        case imageOnly
        case textAndImage
    }
}

#Preview {
    NotificationView(homeViewModel: HomeViewModel())
}

