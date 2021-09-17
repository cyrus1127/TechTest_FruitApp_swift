//
//  Datas.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 14/9/2021.
//

import UIKit
import Foundation


struct FrultProductData : Hashable, Codable, Identifiable {
    var id = UUID()
    var type : String
    var price : Double
    var weight : Int64
    
    static func initWithDic (dataDic : Dictionary<String,Any>) -> FrultProductData{
        
        var v_type : String?
        var v_price : Double?
        var v_weight : Int64?
        
        for key in dataDic.keys{
            if(key == "type"){
                v_type = try? dataDic[key] as? String
            }else if(key == "price"){
                v_price = try? dataDic[key] as? Double
            }else if(key == "weight"){
                v_weight = try? dataDic[key] as? Int64
            }
        }
        
        return FrultProductData.init(type: v_type ?? "", price: v_price ?? 0, weight: v_weight ?? 0)
    }
}

var FrultProductDatas :[FrultProductData] = []
//Model
func loadFrultDatas(_ data : Data) -> [FrultProductData]{
    do {
        var objList = Array<FrultProductData>.init()
        
        if let dicData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
            for key in dicData.keys {
                if(key == "fruit"){
                    if let arr = dicData[key] as? Array<Dictionary<String,Any>>{
                        for dic in arr{
                            let dicObj = FrultProductData.initWithDic(dataDic: dic)
                            objList.append(dicObj)
                        }
                    }
                }
            }
        }
        return objList
    } catch {
        fatalError("data \(data) :\n\(error)")
    }
}
