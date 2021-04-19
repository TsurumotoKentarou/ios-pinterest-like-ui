//
//  TermLabel.swift
//  PinterestLikeUI
//
//  Created by 鶴本賢太朗 on 2021/04/19.
//

import SwiftUI

struct TermLabel: View {
    
    @State var datas: [CustomData] = DataFactory.datas()
    
    var body: some View {

        ScrollView {
            GeometryReader { geometry in
                userPostsList(geometryReader: geometry)
            }
        }
        .background(Color.red)
    }
    
    private func userPostsList(geometryReader: GeometryProxy) -> some View {
        let columnCount: Int = 2
        let xMargin: CGFloat = 50
        let width: CGFloat = UIScreen.main.bounds.width / 2 - (xMargin * CGFloat(columnCount+1)) / 2
        let columns: [GridItem] = Array(repeating: .init(.fixed(width), spacing: xMargin), count: columnCount)
        
        return ZStack(alignment: .topLeading) {
            
            ForEach(datas) { data in
                generateContent(in: geometryReader, data: data, width: width, xMargin: xMargin)
//                        .frame(minHeight: 150)
//                        .frame(maxHeight: 400)
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy, data: CustomData, width: CGFloat, xMargin: CGFloat) -> some View {
        var tempLeftHeight: CGFloat = .zero
        var tempRightHeight: CGFloat = .zero
        
        return ItemView(content: data.content, width: width)
            .alignmentGuide(.top, computeValue: {d in
                //                let result = tempHeight
                //                if data.id == datas.last?.id {
                //                    tempHeight = 0 // last item
                //                }
                let result: CGFloat
                // 左と右どちらが高さが低いか
                if tempLeftHeight <= tempRightHeight {
                    result = tempLeftHeight
                    tempLeftHeight += d.height
                }
                else {
                    result = tempRightHeight
                    tempRightHeight += d.height
                }
                print("tempLeftHeight: \(tempLeftHeight), tempRightHeight: \(tempRightHeight)")
//                print("width: \(d.width), height: \(d.height)")
                return result
            })
            .alignmentGuide(.leading, computeValue: { d in
                let result: CGFloat
                // 左が空いている
                if tempLeftHeight <= tempRightHeight {
                    result = xMargin
                }
                else {
                    result = xMargin*2 + width
                }

                return result
            })
    }
}

struct TermLabel_Previews: PreviewProvider {
    static var previews: some View {
        TermLabel()
    }
}
