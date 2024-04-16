//
//  CameraView.swift
//  MusicMoodApp
//
//  Created by Skylar M. Purks on 4/14/24.
//


import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cameraVM: CameraViewModel
    @State private var imageSelected = false
    @State private var isCameraAuthorized = false
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            Spacer()

            if isCameraAuthorized {
                Button("Take Picture") {
                    self.imageSelected = true
                }
                .padding()
                .sheet(isPresented: $imageSelected, onDismiss: loadImage) {
                    ImagePicker(selectedImage: self.$cameraVM.Image) 
                }
            } else {
                Text("Camera access is required to take pictures.")
                    .padding()
            }

            Spacer()
        }
        .onAppear {
            checkCameraAuthorization()
        }
    }

    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                isCameraAuthorized = true
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        self.isCameraAuthorized = granted
                    }
                }
            default:
                isCameraAuthorized = false
        }
    }

    func loadImage() {
        self.isPresented = false
        // Implement what to do after the image is loaded
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

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Required by protocol
    }

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

////Preview {
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView(, isPresented: false).environmentObject(AuthViewModel()).environmentObject(CameraViewModel())
//    }
//}
