//
//  AllClickCustomTextView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 5/2/24.
//

import SwiftUI

struct AllClickCustomTextView: UIViewRepresentable {
    var viewModel: AllClickGameViewModel
    
    @Binding var text: String
    @Binding var height: CGFloat
    @Binding var shouldBecomeFirstResponder: Bool
    
    func makeCoordinator() -> Coordinator {
        return AllClickCustomTextView.Coordinator(viewModel: viewModel, parent: self)
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.font = UIFont(name: "NeoDunggeunmoPro-Regular", size: 18)
        view.delegate = context.coordinator
        view.backgroundColor = .white
        context.coordinator.setTextView(view)
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
            context.coordinator.updateFirstResponder()
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var viewModel: AllClickGameViewModel
        
        var parent: AllClickCustomTextView
        var textView: UITextView?
        
        init(viewModel: AllClickGameViewModel, parent: AllClickCustomTextView) {
            self.viewModel = viewModel
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = ""
                textView.textColor = .kuText
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            self.parent.shouldBecomeFirstResponder = false
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                checkRightText(newText: textView.text)
                clearText()
                return false
            }
            return true
        }
        
        func setTextView(_ textView: UITextView) {
            self.textView = textView
        }
        
        func updateFirstResponder() {
            if parent.shouldBecomeFirstResponder {
                textView?.becomeFirstResponder()
            } else {
                textView?.resignFirstResponder()
            }
        }
        
        func clearText() {
            textView?.text = ""
        }
        
        func checkRightText(newText: String) {
            if let index = viewModel.subjects.firstIndex(where: { $0.title == newText }) {
                viewModel.calculateScore(index: index)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.viewModel.subjects.remove(at: index)
                    self.viewModel.soundManager.playSound(sound: .classCorrect)
                }
            }
        }
    }
}
