//
//  ScanDocumentView.swift
//  Text Recognition Sample
//
//  Created by Stefan Blos on 25.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import VisionKit
import Vision

struct ScanDocumentView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var recognizedText: Binding<String>
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan)
            let processedText = recognizeText(from: extractedImages)
            recognizedText.wrappedValue = processedText
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
        
        fileprivate func recognizeText(from images: [CGImage]) -> String {
            var entireRecognizedText = ""
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    print("Bad observation")
                    return
                }
                
                let maximumRecognitionCandidates = 1
               
                for observation in observations {
                    
                    
                guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else {
                        print("no candidate")
                        continue }
                    print(candidate)
                    entireRecognizedText += "\(candidate.string)\n"
                }
                let zero: Unicode.Scalar = "0"
                let nine: Unicode.Scalar = "9"
                var letterArray = [String]()
                var n = 0
                var letterWasDigit = false
                for var letter in entireRecognizedText.unicodeScalars {
                    if letterWasDigit{
                        if String(letter) == "\n" {
                            letter = " "
                            print("digit and space detected")
                        }
                        letterWasDigit = false
                    }
                    letterArray.append(String(letter))
                    switch letter.value {
                    case zero.value...nine.value:
                        print(n)
                        print("\(letter) is a digit")
                        letterWasDigit = true
                    default:
                        //return
                    print("\(letter) is a letter")
                        
                    }
                    
                    n = n + 1
                }

                print(letterArray.joined())
                entireRecognizedText = letterArray.joined()
               // entireRecognizedText = entireRecognizedText.replacingOccurrences(of: "\n", with: "")
            }
            
         //   recognizeTextRequest.
             
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                recognizeTextRequest.usesLanguageCorrection = false
                recognizeTextRequest.recognitionLevel = .accurate
                recognizeTextRequest.customWords = ["\n1 ", "\n2 ", "\n3 ", "\n4 ", "\n5 ", "\n6 ", "\n7 ", "\n8 ", "\n9 ", "ml", "g", "kg", "lb", "1 mm"]
                
               // try? requestHandler.perform([recognizeTextRequest])
                do {
                    try requestHandler.perform([recognizeTextRequest])
                } catch {
                    print(error)
                }
            }
            return entireRecognizedText
        }

    }
}
