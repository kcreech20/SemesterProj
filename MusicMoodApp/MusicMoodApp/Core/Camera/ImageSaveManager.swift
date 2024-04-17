import UIKit

class ImageStorageManager {
    static func saveImage(_ image: UIImage) -> URL? {
        if let imageData = image.jpegData(compressionQuality: 1) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let filename = documentsDirectory.appendingPathComponent("capturedImage.jpg")

            // Attempt to save the image to the specified path
            do {
                try imageData.write(to: filename)
                print("Saved image to: \(filename)")
                return filename
            } catch {
                print("Error saving image: \(error)")
                return nil
            }
        }
        return nil
    }
}
