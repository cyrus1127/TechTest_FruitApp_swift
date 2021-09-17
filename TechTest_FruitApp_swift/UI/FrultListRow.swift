//
//  FrultListRow.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 15/9/2021.
//

import SwiftUI

struct FrultListRow: View {
    var data : FrultProductData!
    var body: some View {
        HStack{
            Text(data.type).font(.title2).bold().frame(minWidth: 100, idealWidth: 250, maxWidth: .infinity, minHeight: 50, idealHeight: 80, maxHeight: 100, alignment: .center)
        }
    }
}

struct FrultListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            FrultListRow(data: FrultProductData.init(type: "apple+apple", price: 9999, weight: 9999))
            FrultListRow(data: FrultProductData.init(type: "strawberry+banana+kumquat", price: 9999, weight: 9999))
        }.previewLayout(.fixed(width: 320, height: 70))
        
    }
}
