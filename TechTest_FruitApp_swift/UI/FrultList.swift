//
//  FrultList.swift
//  TechTest_FruitApp_swift
//
//  Created by Chun Yip Lam on 15/9/2021.
//

import SwiftUI

struct FrultList: View {
    @ObservedObject var viewUpdateModel = ListViewUpdateModel()
    
    var body: some View {
        NavigationView{
            Text("").navigationTitle("").navigationBarTitleDisplayMode(.inline)
            
            if viewUpdateModel.items.count == 0 {
                //The view layout when empty data
                VStack{
                    Text("Welcome To Frult App").font(.title)
                    HStack{
                        Button("Press to reach our Products"){
                            viewUpdateModel.requestDataUpdate()
                        }.padding(.all, 5)
                        
                        //Check if is requesting
                        if viewUpdateModel.requesting {
                            //Add the progress indicator
                            ProgressView(value: 0).progressViewStyle(CircularProgressViewStyle(tint: Color.gray)).padding(.trailing, 5)
                        }
                    }.border(Color.blue, width: 1).cornerRadius(5.0)
                }
                
            }else{
                //The view layout with datas
                List(viewUpdateModel.items){ data in
                    NavigationLink(destination: FrultDetail(data: data)){
                        FrultListRow(data:data)
                    }.navigationBarItems(trailing:
                                            HStack{
                                                Button("Refresh") { viewUpdateModel.requestDataUpdate() }.padding(.trailing, 5)
                                                
                                                //Check if is requesting
                                                if viewUpdateModel.requesting {
                                                    //Add the progress indicator
                                                    ProgressView(value: 0).progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                                                }
                                            })
                }
                .navigationBarTitle("Our Frult Product")
                .onDisappear{
                    //Submit the DetailView display record
                    if(CommonUtility.instance().getIsTimeCounting()){
                        ConnectionUtility.instance().submitAppUsageState(event: .display, data: "\(CommonUtility.instance().getTimediff())")
                    }
                }
            }
        }
    }
    
    /// mark - view model class for this list view
    class ListViewUpdateModel: ObservableObject{
        @Published var items = FrultProductDatas
        @Published var requesting = false {
            didSet{
                debugPrint("\(requesting)")
            }
        }
        
        public func requestDataUpdate(){
            requesting = true
            ConnectionUtility.instance().getProductListData { (isSuccess:Bool) in
                if(isSuccess){
                    //update/replace the holding datas , else do keep the latest data
                    self.items = FrultProductDatas
                }
                self.requesting = false
            }
        }
    }
}

struct FrultList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FrultList()
        }
    }
}



