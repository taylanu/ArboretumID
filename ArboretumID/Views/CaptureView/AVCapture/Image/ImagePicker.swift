//
//  ImagePicker.swift
//  ArborID
//
//  Created by Taylan Unal on 11/22/20.
//

import UIKit
import SwiftUI
import CoreML
import Vision

// MARK: - ImagePicker provides user option to select images from Gallery to be recognized
// Adapted from tutorial: https://www.appcoda.com/swiftui-camera-photo-library/ and https://github.com/DavidDuarte22/ImageClassification02

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var result: String
    @Binding var selectedImage: UIImage
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: Classification.shared)
        }
        
        @objc func onDidReceiveData(_ notification:Notification) {
            if let result = notification.userInfo?["request"] as? VNCoreMLRequest {
                processObservations(for: result, error: nil)
            }
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                Classification.shared.classify(image: image)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func processObservations(for request: VNRequest, error: Error?) {
            // The request’s completion handler is called on the same background queue from which you launched the request.
            DispatchQueue.main.async {
                // If everything went well, the request’s results array contains one or more VNClassificationObservation objects
                if let results = request.results as? [VNClassificationObservation] {
                    // Assuming the array is not empty, it contains a VNClassificationObservation object for each possible class
                    if results.isEmpty {
                        self.parent.result = "nothing found"
                    } else if results[0].confidence < 0.6 {
                        self.parent.result = "not sure"
                    } else {
                        let firstItems = results.prefix(3).map { result in
                            String(format: "%@ %.1f%%", result.identifier, result.confidence * 100)
                        }
                        self.parent.result = firstItems.joined(separator: "\n")
                    }
                } else if let error = error {
                    self.parent.result = "error: \(error.localizedDescription)"
                } else {
                    self.parent.result = "???"
                }
            }
        }
    }
}
extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}

