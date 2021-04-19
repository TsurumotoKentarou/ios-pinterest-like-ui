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
        GeometryReader { geometry in
            ScrollView {
                userPostsList
            }
            .background(Color.red)
        }
    }
    
    private var userPostsList: some View {
        let columnCount: Int = 2
        let xMargin: CGFloat = 50
        let width: CGFloat = UIScreen.main.bounds.width / 2 - (xMargin * CGFloat(columnCount+1)) / 2
        let columns: [GridItem] = Array(repeating: .init(.fixed(width), spacing: xMargin), count: columnCount)
        
        return ZStack(alignment: .topLeading) {
            LazyVGrid(columns: columns, spacing: xMargin) {
                ForEach(datas) { data in
                    GeometryReader { geometryReader in
                        generateContent(in: geometryReader, data: data, width: width)
                            .frame(minHeight: 150)
                            .frame(maxHeight: 400)
                    }
                }
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy, data: CustomData, width: CGFloat) -> some View {
        var tempWidth = CGFloat.zero
        var tempHeight = CGFloat.zero
        
        return ItemView(content: data.content, width: width)
            .alignmentGuide(.leading, computeValue: { d in
                if (abs(width - d.width) > g.size.width)
                {
                    tempWidth = 0
                    tempHeight -= d.height
                }
                
                let result = width
                
                if data.id == datas.last?.id {
                    tempWidth = 0
                }
                else {
                    tempWidth -= d.width
                }
                
                return result
            })
            .alignmentGuide(.top, computeValue: {d in
                let result = tempHeight
                if data.id == datas.last?.id {
                    tempHeight = 0 // last item
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
