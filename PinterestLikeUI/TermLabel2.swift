//
//  TermLabel22.swift
//  PinterestLikeUI
//
//  Created by 鶴本賢太朗 on 2021/04/19.
//

import SwiftUI

struct TermLabel2: View {
    
    private let texts: [String] = DataFactory.datas()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                self.generateContent(in: geometry)
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        let columnCount: Int = 2
        let xMargin: CGFloat = 50
        let onewidth: CGFloat = UIScreen.main.bounds.width / 2 - (xMargin * CGFloat(columnCount+1)) / 2
        
        var tempLeftHeight: CGFloat = .zero
        var tempRightHeight: CGFloat = .zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(texts, id: \.self) { text in
                self.text(for: text, width: onewidth)
                    .padding(.horizontal, xMargin)
                    .padding(.vertical, 3)
                    .alignmentGuide(.top, computeValue: { d in
                        let result: CGFloat
                        // 左と右どちらが高さが低いか
                        if tempLeftHeight > tempRightHeight {
                            result = tempLeftHeight
                            tempLeftHeight -= d.height
                        }
                        else {
                            result = tempRightHeight
                            tempRightHeight -= d.height
                        }
                        
                        if text == texts.last {
                            tempRightHeight = 0
                            tempLeftHeight = 0
                        }
                        return result
                    })
                    .alignmentGuide(.leading, computeValue: { d in
                        let result: CGFloat
                        // 左が空いている
                        if tempLeftHeight > tempRightHeight {
                            result = xMargin
                        }
                        else {
                            result = xMargin*2 + onewidth
                        }
                        return result
                    })
            }
        }
    }
    
    
    private func text(for text: String, width: CGFloat) -> some View {
        return Text(text)
            .font(.body)
            .background(Color.orange)
            .frame(width: width)
    }
}

struct TermLabel2_Previews: PreviewProvider {
    static var previews: some View {
        TermLabel2()
    }
}
