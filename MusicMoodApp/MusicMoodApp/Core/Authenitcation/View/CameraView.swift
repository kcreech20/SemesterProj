//
//  CameraView.swift
//  MusicMoodApp
//
//  Created by Skylar M. Purks on 4/14/24.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cameraVM: CameraViewModel
    @State private var imageSelected = false
    
    var body: some View {
        VStack {
            Spacer()
//            Spacer()
//            if let imageType = cameraVM.Image {
//                Image(uiImage: UIImage(data: imageType)!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
//            } else {
            Button("Take Picture") {
                            self.imageSelected = true
                        }
                        .padding()
                        Spacer()
                    }
                    .sheet(isPresented: $imageSelected, onDismiss: loadImage) {
                        ImagePicker(selectedImage: self.$cameraVM.Image)
                    }
        
        Spacer()
        
        Button(action: {
            viewModel.signOut()
        }) {
            HStack {
                Text("SIGN OUT")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right.circle.fill")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            .background(Color.red)
            .cornerRadius(24)
            }
        }

        func loadImage() {
        }
    }

    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: Data?

        func makeUIViewController(context: Context) -> UIImagePickerController {
                let picker = UIImagePickerController()
                picker.delegate = context.coordinator
                picker.sourceType = .camera
                return picker
            }

            func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

            func makeCoordinator() -> Coordinator {
                Coordinator(self)
            }

            class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
                let parent: ImagePicker

                init(_ parent: ImagePicker) {
                    self.parent = parent
                }

                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    if let image = info[.originalImage] as? UIImage {
                        parent.selectedImage = image.jpegData(compressionQuality: 1.0)
                }
                picker.dismiss(animated: true)
            }
        }
    }

#Preview {
    CameraView()
}

