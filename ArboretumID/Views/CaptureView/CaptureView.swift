//
//  CaptureView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/20/20.
//

import UIKit
import SwiftUI

// MARK: - Presents the Camera to Capture Images of Plants or Placards in the Arboretum
// Adapted from tutorial: https://www.appcoda.com/swiftui-camera-photo-library/

struct CaptureView: View {
    // Displays image captured or selected
    @State private var image = UIImage()
    
    // Choose which view to display
    @State private var showingPhotoLibrary = false
    @State private var showingCamera = false
    @State private var showingLiveView = false
    
    // Presents results of ML Model
    @State private var mlResults = "Choose an Image to Recognize"
    
    var body: some View {
        ZStack(alignment: .bottom){ //
            // Presents image captured
            ZStack(alignment: .top){
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                Text(mlResults)
                    .font(.title3)
                    .frame(minWidth: 200, idealWidth: 200, maxWidth: 300, minHeight: 50, idealHeight: 50, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }

            HStack(alignment: .bottom){
                Button(action: {self.showingPhotoLibrary = true}) {
                    captureButton(icon: "photo.on.rectangle.angled", name: "Library")
                        .sheet(isPresented: $showingCamera) {
                            ImagePicker(result: self.$mlResults, selectedImage: self.$image, sourceType: .camera)
                        }
                }
                Button(action: {self.showingCamera = true}) {
                    captureButton(icon: "camera.aperture", name: "Camera")
                        .sheet(isPresented: $showingPhotoLibrary) {
                            ImagePicker(result: self.$mlResults, selectedImage: self.$image, sourceType: .photoLibrary)
                        }
                }
                Button(action: {self.showingLiveView = true}) {
                    captureButton(icon: "livephoto.play", name: "Live")
                        .sheet(isPresented: $showingLiveView) {
                            CameraViewController()
                        }
                }
            }
        }

    }
}

// MARK: -- Defines Button view used by Capture, Library, LiveView
// Show Live View by default, allow capture from live view, then offer Library access.
struct captureButton : View{
    var buttonIcon : String
    var buttonName : String
    
    init(icon: String, name: String){
        buttonIcon = icon
        buttonName = name
    }
    var body : some View{
        HStack {
            Image(systemName: buttonIcon)
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Text(buttonName)
                .font(.body)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}
