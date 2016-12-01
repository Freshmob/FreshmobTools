//
//  UIImageExtensions.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 30/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

public extension UIImage {
    var tempFileUrl: URL? {
        let tempUrlString = NSTemporaryDirectory().appending(NSUUID().uuidString).appending(".jpg")
        guard let data = UIImageJPEGRepresentation(self, 1) else {
            return nil
        }
        let tempUrl = URL(fileURLWithPath: tempUrlString)
        try! data.write(to: tempUrl, options: .atomic)
        return tempUrl
    }
}

public extension UIImage {
    static func fromFileUrl(_ url: URL) -> UIImage? {
        let type = url.pathExtension.lowercased()
        switch type {
        case "jpg", "jpeg", "png":
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            return image
        case "mov", "mp4", "m4v":
            return fetchImage(fromMovieUrl: url)
        case "pdf":
            return fetchImage(fromPdfUrl: url)
        default:
            return nil
        }
    }
    
    private static func fetchImage(fromAssetLibraryUrl url: URL) -> UIImage? {
        let assets = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
        guard let asset = assets.firstObject else {
            return nil
        }
        let size = CGSize(width: 500, height: 500)
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        var theImage: UIImage?
        manager.requestImage(for: asset, targetSize: size , contentMode: PHImageContentMode.default, options: options, resultHandler: { (image, metadata) in
            theImage = image
        })
        return theImage
    }
    
    private static func fetchImage(fromMovieUrl url: URL) -> UIImage? {
        let asset = AVURLAsset(url: url, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            return image
        } catch {
            return nil
        }
    }
    
    private static func fetchImage(fromPdfUrl url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        let pageRect = page.getBoxRect(.mediaBox)
        var img: UIImage?
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            img = renderer.image { ctx in
                UIColor.white.set()
                ctx.fill(pageRect)
                ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height);
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0);
                ctx.cgContext.drawPDFPage(page);
            }
        }
        return img
    }
}
