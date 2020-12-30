import UIKit
import MobileCoreServices

@objc(DirectoryPicker)
class DirectoryPicker: NSObject, UIDocumentPickerDelegate {
  var resolve: RCTPromiseResolveBlock? = nil;
  var reject: RCTPromiseRejectBlock? = nil;
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    let url = urls[0]
    
    // Start accessing a security-scoped resource.
    guard url.startAccessingSecurityScopedResource() else {
      // Handle the failure here.
      return
    }
    
    // Make sure you release the security-scoped resource when you are done.
    defer { url.stopAccessingSecurityScopedResource() }
    
    do {
      let bookmarkData = try url.bookmarkData(options: .minimalBookmark, includingResourceValuesForKeys: nil, relativeTo: nil)
      
      let filename = getDocumentsDirectory().appendingPathComponent("test")
      
      try bookmarkData.write(to: filename)
      resolve!("")
    } catch {
      reject!(error.localizedDescription, error.localizedDescription, error)
    }
  }
  
  func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    resolve!(nil);
  }
  
  @objc(pickFolder:rejecter:)
  public func pickFolder(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject:@escaping RCTPromiseRejectBlock) -> Void {
    self.resolve = resolve;
    self.reject = reject;
    DispatchQueue.main.async {
      let documentPicker =
        UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String],
                                       in: .open)
      documentPicker.delegate = self
      self.topMostViewController()?.present(documentPicker, animated: true, completion: nil)
    }
  }
  
  @objc
  fileprivate func topMostViewController() -> UIViewController? {
    var ret: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    repeat {
      if let presented = ret?.presentedViewController {
        ret = presented
      } else {
        break
      }
    } while(true)
    return ret
  }
  
  @objc
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc(createFolder:folderName:)
  public func createFolder(_ path: String, folderName: String) {
    var url: URL? = nil
    
    do {
      let filename = getDocumentsDirectory().appendingPathComponent("test")
      let bookmarkData = try Data(contentsOf: filename)
      var isStale = false
      url = try URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale)
    } catch {
      print(error.localizedDescription)
      return
    }
    
    //    let url = URL(fileURLWithPath: path);
    //    let needTo = url.startAccessingSecurityScopedResource()
    guard url!.startAccessingSecurityScopedResource() else {
      // Handle the failure here.
      print("THERE WAS A FAILURE HERE")
      return
    }
    
    defer { url!.stopAccessingSecurityScopedResource() }
    
    let fileManager = FileManager.default
    let filePath =  url!.appendingPathComponent("\(folderName)")
    do {
      try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
    } catch {
      print(error.localizedDescription)
    }
    
    //
    //    if needTo {
    //      url.stopAccessingSecurityScopedResource()
    //      print("I am done")
    //    }
  }
}

