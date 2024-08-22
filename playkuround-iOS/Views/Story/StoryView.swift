//
//  StoryView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 7/14/24.
//

import SwiftUI

struct StoryView: View {
    @State private var currentStoryIndex: Int = 0
    @Binding var showStoryView: Bool
    var stories: [Story]
    
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
                                Text(stories[currentStoryIndex].title)
                                    .font(.neo18)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                                    .lineSpacing(18 * 0.3)
                                    .padding(.top, 19)
                                
                                Text(StringLiterals.Story.new)
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuRed)
                                    .padding(.top, 21)
                            }
                            
                            stories[currentStoryIndex].image
                                .padding(.top, 12)
                            
                            Image(.storyDescriptionBlock)
                                .overlay(alignment: .top) {
                                    Text(stories[currentStoryIndex].description)
                                        .font(.neo15)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                        .lineSpacing(15 * 0.3)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 7)
                                        .padding(.horizontal, 12)
                                }
                                .padding(.top, 12)
                            
                            HStack {
                                ForEach(getStoryBlockImages(for: currentStoryIndex), id: \.self) { imageName in
                                    Image(imageName)
                                }
                            }
                            .padding(.top, 13)
                        }
                        
                        HStack {
                            Button(action: {
                                if currentStoryIndex > 0 {
                                    currentStoryIndex -= 1
                                }
                            }, label: {
                                Image(.storyLeftArrow)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                if currentStoryIndex < stories.count - 1 {
                                    currentStoryIndex += 1
                                }
                            }, label: {
                                Image(.storyRightArrow)
                            })
                        }
                        .padding(.horizontal, 10)
                    }
                }
        }
    }
    
    func getStoryBlockImages(for index: Int) -> [String] {
        var images: [String] = []
        
        for i in 0..<stories.count {
            if i < index {
                images.append("previewStoryBlock")
            } else if i == index {
                images.append("nowStoryBlock")
            } else {
                images.append("lockStoryBlock")
            }
        }
        
        return images
    }
}

func lockDescriptionView() -> some View {
    return Image(.storyLockDescriptionBackground)
        .overlay {
            Text(StringLiterals.Story.lock)
                .font(.neo15)
                .foregroundStyle(.kuText)
                .kerning(-0.41)
                .lineSpacing(15 * 0.3)
                .multilineTextAlignment(.center)
        }
}

#Preview {
    StoryView(showStoryView: .constant(true), stories: storys)
}
