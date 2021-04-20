//
//  TermLabel22.swift
//  PinterestLikeUI
//
//  Created by 鶴本賢太朗 on 2021/04/19.
//

import SwiftUI

struct TermLabel2: View {
    
    enum TextType: String, CaseIterable {
        case term = "利用規約"
        case text1 = "あああああああああああああああああああああああああああああ"
        
        case text2 = "及び"
        case text3 = "及び4"
        case privacyPolicy = "上記のいずれかをク上記のいずれかをク上記のいずれかをク"
        case text4 = "に同意するものとしますに同意するものとしますに同意するものとしますに同意するものとします"
    }
    
    private let textTypes: [TextType] = TextType.allCases
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
                .background(Color.yellow)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
        
        let columnCount: Int = 2
        let xMargin: CGFloat = 50
        let onewidth: CGFloat = UIScreen.main.bounds.width / 2 - (xMargin * CGFloat(columnCount+1)) / 2
        let columns: [GridItem] = Array(repeating: .init(.fixed(onewidth), spacing: xMargin), count: columnCount)
        
        var tempLeftHeight: CGFloat = .zero
        var tempRightHeight: CGFloat = .zero
        
        return ZStack(alignment: .topLeading) {
//            LazyVGrid(columns: columns, spacing: xMargin) {
//
//            }
            ForEach(textTypes, id: \.self) { textType in
                self.text(for: textType, width: onewidth)
                    .padding(.horizontal, xMargin)
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
                        
                        if textType == textTypes.last {
                            tempRightHeight = 0
                            tempLeftHeight = 0
//                            print("\n")
                        }
                        print("\(textType): \(result)")
//                        print("tempLeftHeight: \(tempLeftHeight), tempRightHeight: \(tempRightHeight)")
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
                            result = xMargin*2 + onewidth
                        }
                        return result
                    })
            }
        }
    }
    
    
    func text(for textType: TextType, width: CGFloat) -> some View {
//        Rectangle()
//            .foregroundColor(.blue)
//            .frame(width: width)
        baseText(textType: textType)
            .frame(width: width)
    }
    
    private func baseText(textType: TextType) -> some View {
        return Text(textType.rawValue)
            .font(.body)
            .foregroundColor(.blue)
            .background(Color.red)
    }
}

struct TermLabel2_Previews: PreviewProvider {
    static var previews: some View {
        TermLabel2()
    }
}
