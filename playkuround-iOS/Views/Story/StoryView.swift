//
//  StoryView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 7/14/24.
//

import SwiftUI

struct StoryView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @Binding var showStoryView: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    showStoryView.toggle()
                    rootViewModel.currentStoryIndex = 0
                }
            
            let currentStory = rootViewModel.stories[rootViewModel.currentStoryIndex]
            let isLocked = currentStory.isLocked
            
            Image(.storyPopupBackground)
                .overlay(alignment: .top) {
                    ZStack {
                        VStack(spacing: 0) {
                            HStack {
                                Text(isLocked ? "#\(currentStory.number). ???" : "#\(currentStory.number). \(currentStory.title)")
                                    .font(.neo18)
                                    .foregroundStyle(.kuText)
                                    .kerning(-0.41)
                                    .lineSpacing(18 * 0.3)
                                    .padding(.top, 19)
                                
                                Text(isLocked || !currentStory.isNew ? "" : StringLiterals.Story.new)
                                    .font(.neo15)
                                    .kerning(-0.41)
                                    .foregroundStyle(.kuRed)
                                    .padding(.top, 21)
                            }
                            
                            Image(isLocked ? "storyLockImage" : currentStory.image)
                                .padding(.top, 12)
                            
                            Image(isLocked ? .storyLockDescriptionBackground : .storyDescriptionBlock)
                                .overlay(alignment: isLocked ? .center : .top) {
                                    Text(isLocked ? StringLiterals.Story.lock : currentStory.description)
                                        .font(.neo15)
                                        .foregroundStyle(.kuText)
                                        .kerning(-0.41)
                                        .lineSpacing(15 * 0.3)
                                        .multilineTextAlignment(isLocked ? .center : .leading)
                                        .padding(.top, isLocked ? -4 : 7)
                                        .padding(.horizontal, 12)
                                }
                                .padding(.top, 12)
                            
                            HStack {
                                ForEach(getStoryBlockImages(for: rootViewModel.currentStoryIndex), id: \.self) { imageName in
                                    Image(imageName)
                                }
                            }
                            .padding(.top, 13)
                        }
                        
                        HStack {
                            if rootViewModel.currentStoryIndex != 0 {
                                Button(action: {
                                    rootViewModel.previousStory()
                                }, label: {
                                    Image(.storyLeftArrow)
                                })
                            }
                            
                            Spacer()
                            
                            if rootViewModel.currentStoryIndex != 5 {
                                Button(action: {
                                    rootViewModel.nextStory()
                                }, label: {
                                    Image(.storyRightArrow)
                                })
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
        }
    }
    
    func getStoryBlockImages(for index: Int) -> [String] {
        var images: [String] = []
        
        for i in 0..<storyList.count {
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
    StoryView(rootViewModel: RootViewModel(), showStoryView: .constant(true))
}
