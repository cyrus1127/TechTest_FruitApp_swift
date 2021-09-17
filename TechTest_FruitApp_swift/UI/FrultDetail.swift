//
//  FrultDetail.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 15/9/2021.
//

import SwiftUI

struct FrultDetail: View {
    var data : FrultProductData?
    
    var body: some View {
        VStack{
            Text("Frult Details").frame(minWidth: 100, idealWidth: 200, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 35, idealHeight: 45, maxHeight: 89, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.largeTitle).padding(.top, 20)
            Group{
                HStack{
                    Text("Type : ")
                    Spacer(minLength: 50)
                    Text(data?.type ?? "")
                }
                HStack{
                    Text("Price : ")
                    Spacer(minLength: 50)
                    Text( String(format: "£ %.2f", data?.price ?? 0))
                }
                HStack{
                    Text("Weight : ")
                    Spacer(minLength: 50)
                    Text("\(data?.weight ?? 0) KG")
                }
            }.frame(minWidth: 50, idealWidth: 100, maxWidth: .infinity, minHeight: 25, idealHeight: 35, maxHeight: 50, alignment: .center).padding().font(.system(size: 25))
            Spacer()
        }.onAppear{
            //set the timemarker here as SwiftUI lift cycle don't have will dismiss
            CommonUtility.instance().setTimemark()
        }
    }
    
}

struct FrultDetail_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = FrultProductData.init(type: "apple+apple", price: 9999.00, weight: 9999)
        FrultDetail(data:sampleData)
    }
}


