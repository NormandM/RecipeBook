/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import PDFKit

class PDFCreator: NSObject {
    let title: String
    let body: String
    let image: UIImage
    let pDfIsPresent: Bool
    let rectImage: UIImage
    var imagePositionTop = CGFloat()
    var imageHeight = CGFloat()
    var titleBottom = CGFloat()
    var bodyTextHeight = CGFloat()
    var imageX = CGFloat()
    var scaledWidth = CGFloat()
    var imageBottom = CGFloat()
    init(title: String, body: String, image: UIImage, pDfIsPresent: Bool, rectImage: UIImage) {
        self.title = title
        self.body = body
        self.image = image
        self.pDfIsPresent = pDfIsPresent
        self.rectImage = rectImage
    }
    
    func createFlyer() -> Data {
        // 1
        let pdfMetaData = [
            kCGPDFContextCreator: "RecipeNook",
            kCGPDFContextAuthor: "",
            kCGPDFContextTitle: title
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // 2
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // 3
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4
        let data = renderer.pdfData { (context) in
            // 5
            context.beginPage()
            // 6
            titleBottom = addTitle(pageRect: pageRect)
            imageBottom = addImage(pageRect: pageRect, imageTop: titleBottom + 30)
            if pDfIsPresent {
            
                addBodyText(pageRect: pageRect, textTop: imageBottom + 50.0)
                addSquareImage(pageRect: pageRect)
            }else{
                addBodyText(pageRect: pageRect, textTop: titleBottom + 20.0)
            }
            addSquareAroundText(pageRect: pageRect)
        }
        return data
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
        // 1
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        // 2
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        // 3
        let titleStringSize = attributedTitle.size()
        // 4
        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0, y: 20, width: titleStringSize.width, height: titleStringSize.height)
        // 5
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addBodyText(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: body, attributes: textAttributes)
        var textRect = CGRect()
        if pDfIsPresent {
            bodyTextHeight = pageRect.height *  0.15
            
        }else{
            bodyTextHeight = pageRect.height *  0.8
        }
        textRect = CGRect(x: imageX, y: textTop + 10, width: scaledWidth,
                              height: bodyTextHeight)
        attributedText.draw(in: textRect)
    }
    
    func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
        var imagePosition = CGFloat()
        if pDfIsPresent {
        let maxHeight = pageRect.height * 0.6
        let maxWidth = pageRect.width * 0.8
        // 2
        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        // 3
        scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio
        // 4
        imageX = (pageRect.width - scaledWidth) / 2.0
        let imageRect = CGRect(x: imageX, y: imageTop,
                               width: scaledWidth, height: scaledHeight)
        imagePositionTop = imageTop
        imageHeight = scaledHeight
        
        image.draw(in: imageRect)
            imagePosition = imageRect.origin.y + imageRect.size.height
            return imagePosition
        }else{
            let pageWidth: CGFloat  = 8.5 * 72.0
            imagePosition = 0.0
            imageX = 130
            scaledWidth = pageWidth - 240
            return imagePosition
        }


        
    }
    func addSquareImage(pageRect: CGRect) {
        let pageWidth: CGFloat  = 8.5 * 72.0
        var x = CGFloat()
        var widthX = CGFloat()
        if imageX - 10 > 119 || imageX == 0{
            x = 120
            widthX = pageWidth - 240
            
        }else{
            x = imageX - 10
            widthX = scaledWidth + 20
        }
        let recRectangle = CGRect(x: x, y: imagePositionTop - 20,
                                  width: (widthX), height: imageHeight + 40)
        rectImage.draw(in: recRectangle )

    }
    func addSquareAroundText(pageRect: CGRect) {
        let pageWidth: CGFloat  = 8.5 * 72.0
        var x = CGFloat()
        var y = CGFloat()
        var heightY = CGFloat()
        var widthX = CGFloat()
        if imageX - 10 > 119 || imageX == 0 {
            x = 120
            widthX = pageWidth - 240
        }else{
            x = imageX - 10
            widthX = scaledWidth + 20
        }
        if pDfIsPresent {
            y = imageBottom + 40
        }else{
            y = titleBottom + 20
        }
        heightY = bodyTextHeight + 40
        let rectRectangle = CGRect(x: x, y: y,
                                   width: (widthX), height: heightY)
        rectImage.draw(in: rectRectangle)
        
    }



    
    
    
}
