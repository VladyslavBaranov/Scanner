//
//  Camera.swift
//  Scanner
//
//  Created by EgorM on 22.01.2022.
//
import SwiftUI
import VisionKit
import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}

final class ContentViewModel: NSObject, ObservableObject {
    @Published var errorMessage: String?
    @Published var imageArray: [UIImage] = []
    
    func getDocumentCameraViewController() -> VNDocumentCameraViewController {
        let vc = VNDocumentCameraViewController()
        vc.delegate = self
        return vc
    }
    
    func editImage(image: UIImage) {
        // imageArray.customMirror
    }
    
    func removeImage(image: UIImage) {
        imageArray.removeAll{$0 == image}
    }
}


extension ContentViewModel: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
      
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
    }
      
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
      print("Did Finish With Scan.")
        for i in 0..<scan.pageCount {
            self.imageArray.append(scan.imageOfPage(at:i))
        }
        controller.dismiss(animated: true, completion: nil)
	}
}

struct CameraView: View {
	@ObservedObject var viewModel: ContentViewModel
	
	var body: some View {

		NavigationView {
			List {
				if let error = viewModel.errorMessage {
					Text(error)
				} else {
					ForEach(viewModel.imageArray, id: \.self) { image in
						Image(uiImage: image)
							.resizable()
							.aspectRatio(contentMode: .fit).contextMenu {
								Button {
                                    cameraShare(image: image)
								} label: {
									Label(LocalizedString(.cameraShare), systemImage: "square.and.arrow.up")
								}
								Divider()
								Button {
									cameraEdit()
								} label: {
									Label(LocalizedString(.cameraEdit), systemImage: "delete.left")
								}
								Divider()
								Button {
									viewModel.removeImage(image: image)
								} label: {
									Label(LocalizedString(.cameraDelete), systemImage: "delete.left")
								}
								
							}
					}
				}
			}
            .navigationTitle(LocalizedString(.cameraYourDocuments))
                .navigationBarItems(leading: Button(action: {
                    shareAll()
                }, label: {
					Text(LocalizedString(.cameraShareAll))
                    
                }).disabled(viewModel.imageArray.count == 0), trailing: Button(action: {
                    cameraScan()
                }, label: {
					Text(LocalizedString(.camereScan))
                })).navigationAppearance(backgroundColor: UIColor(hue: 0.374, saturation: 0.69, brightness: 0.878, alpha: 1), foregroundColor: .systemBackground, tintColor: .systemBackground, hideSeparator: true)
            
                .preferredColorScheme(.light)
             
        }
    }
    func cameraShare(image: UIImage) {
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true)
    }
    func cameraEdit() {
        UIApplication.shared.keyWindow?.rootViewController?.present(viewModel.getDocumentCameraViewController(), animated: true, completion: nil)
    }
    func shareAll() {
        let items = viewModel.imageArray
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true)
    }
    func cameraScan() {
        UIApplication.shared.keyWindow?.rootViewController?.present(viewModel.getDocumentCameraViewController(), animated: true, completion: nil)
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        CameraView(viewModel: ContentViewModel())
    }
}
