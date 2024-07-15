//
//  StoryView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 7/14/24.
//

import SwiftUI

struct StoryView: View {
    @Binding var showStoryView: Bool
    var story: Story
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    showStoryView.toggle()
                }
            
            Image(.storyPopupBackground)
                .overlay(alignment: .top) {
                    ZStack {
                        VStack(spacing: 0) {
                            HStack {
                                Text(story.title)
                                    .font(.neo18)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                                    .lineSpacing(18 * 0.3)
                                    .padding(.top, 19)
                                
                                Text("new!")
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuRed)
                                    .padding(.top, 21)
                            }
                            
                            story.image
                                .padding(.top, 12)
                            
                            Image(.storyDescriptionBlock)
                                .overlay(alignment: .top) {
                                    Text(story.description)
                                        .font(.neo15)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                        .lineSpacing(15 * 0.3)
                                        .padding(.top, 7)
                                        .padding(.horizontal, 12)
                                }
                                .padding(.top, 12)
                            
                            HStack {
                                Image(.previewStoryBlock)
                                Image(.previewStoryBlock)
                                Image(.previewStoryBlock)
                                Image(.nowStoryBlock)
                                Image(.lockStoryBlock)
                                Image(.lockStoryBlock)
                            }
                            .padding(.top, 13)
                        }
                        
                        HStack {
                            Image(.storyLeftArrow)
                            
                            Spacer()
                            
                            Image(.storyRightArrow)
                        }
                        .padding(.horizontal, 10)
                    }
                }
        }
    }
}

func lockDescriptionView() -> some View {
    return Image(.storyLockDescriptionBackground)
        .overlay {
            Text("게임을 플레이하면\n새로운 스토리가 열려요!")
                .font(.neo15)
                .foregroundStyle(.kuText)
                .kerning(-0.41)
                .lineSpacing(15 * 0.3)
                .multilineTextAlignment(.center)
        }
}

#Preview {
    StoryView(showStoryView: .constant(true), story: storys[3])
}
