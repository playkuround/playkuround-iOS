//
//  AllClickCustomTextView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 5/2/24.
//

import SwiftUI

struct AllClickCustomTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    @Binding var shouldBecomeFirstResponder: Bool
    
    func makeCoordinator() -> Coordinator {
        return AllClickCustomTextView.Coordinator(parent: self)
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
        var parent: AllClickCustomTextView
        var textView: UITextView?
        
        init(parent: AllClickCustomTextView) {
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
    }
}
