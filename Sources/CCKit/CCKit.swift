import CoreGraphics
import Foundation

struct CCKit {
    let text = "Hello World"
}
//enum GraphicsType {
//    case bitmap
//    case pdf(URL)
//}
//
//
//
//class Graphics {
//    let type: GraphicsType
//    let size: CGSize
//    let context: CGContext
//
//    init(type: GraphicsType, size: CGSize) {
//        self.type = type
//        self.size = size
//
//        switch type {
//        case .bitmap:
//            let colorspace = CGColorSpaceCreateDeviceRGB()
//            guard let ctx = CGContext(data: nil,
//                                      width: Int(size.width),
//                                      height: Int(size.height),
//                                      bitsPerComponent: 8,
//                                      bytesPerRow: colorspace.numberOfComponents * 8 * Int(size.width),
//                                      space: colorspace,
//                                      bitmapInfo: 0) else {
//                                        fatalError("Could not create context")
//            }
//            self.context = ctx
//        case .pdf(let url):
//            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//            guard let ctx = CGContext(url, mediaBox: &rect, nil) else {
//                fatalError("Could not create PDF context")
//            }
//        }
//    }
//}
//
//class Canvas {
//    let context: CGContext
//
//    open func draw() {
//        CGColor(
//    }
//}
