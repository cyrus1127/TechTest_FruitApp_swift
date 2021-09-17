//
//  ConnectionUtility.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 14/9/2021.
//

import UIKit
import Foundation

class ConnectionUtility: NSObject {
    var timeMarker : NSNumber!
    
    let gateway = "https://raw.githubusercontent.com/"
    let path = "fmtvp/recruit-test-data/master/"
    
    enum EventType {
        case load
        case display
        case error
    }
    
    static var myIntance : ConnectionUtility!
    static func instance () -> ConnectionUtility {
        if ((myIntance as ConnectionUtility?) == nil) {
            myIntance = ConnectionUtility.init();
        }
        return myIntance
    }
    
    //Base request
    public func makeRequest ( url : URL , completionHandler :@escaping (Data , HTTPURLResponse) -> Void  ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //Submit the API request traffic time
            if(CommonUtility.instance().getIsTimeCounting()){
                DispatchQueue.main.sync {
                    self.submitAppUsageState(event: .load, data: "\(CommonUtility.instance().getTimediff())")
                }
            }
            
            //check with response error
            if let error = error {
                self.handleClientError(error: error)
                return
            }
            
            //check with response code
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response: response as! HTTPURLResponse)
                return
            }
            
            completionHandler(data!, httpResponse)
        }
        task.resume()
    }
    
    public func getProductListData ( completionHandler :@escaping (Bool) -> Void  ) {
        
        //Mark down the current time before start request
        CommonUtility.instance().setTimemark()
        
        let url = URL(string: "\(gateway)\(path)data.json")!
        makeRequest(url: url) { (data : Data, response : HTTPURLResponse) in
            if let mimeType = response.mimeType, mimeType == "text/plain",
                let string = String(data: data, encoding: .utf8) {

                DispatchQueue.main.sync {
                    if string.count != 0 && data.count != 0 {
                        FrultProductDatas = loadFrultDatas(data);
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }
            }
        }
    }
    
    public func submitAppUsageState(event:EventType , data :String){
        
        //do handle the URLEncoding , if encode fail use the origial data
        var encodedStr = data.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? data
        var urlStr = "\(gateway)\(path)stats?"
        
        switch event {
        case .load:
            urlStr.append("event=load&data=")
        case .display:
            urlStr.append("event=display&data=")
        case .error:
            urlStr.append("event=error&data=")
            //find and replace the "." full stop UTF8 character in msg
            if encodedStr.range(of: ".") != nil {
                encodedStr = encodedStr.replacingOccurrences(of: ".", with: "%2E")
            }
        }
        urlStr.append(encodedStr)
        
        let url = URL(string: urlStr)!
        makeRequest(url: url) { (data : Data, response : HTTPURLResponse) in
            //TODO : make some handling
        }
    }
    
     
    
    func handleClientError(error: Error){
        DispatchQueue.main.sync {
            let alertCont = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alertCont.addAction(UIAlertAction.init(title: "Okay", style: UIAlertAction.Style.cancel, handler: { (action : UIAlertAction) in
                alertCont.dismiss(animated: true){
                    self.submitAppUsageState(event: .error, data: error.localizedDescription)
                }
            }))
            
            UIApplication.shared.windows.first?.rootViewController?.present(alertCont, animated: true, completion: {
                NSLog("")
            })
        }
    }
    
    func handleServerError(response : HTTPURLResponse){
        
    }
    
}
