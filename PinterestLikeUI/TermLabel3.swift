//
//  TermLabel3.swift
//  Herely-iOS
//
//  Created by 鶴本賢太朗 on 2021/02/07.
//

import SwiftUI

struct TermLabel3: View {
    
    enum TextType: String, CaseIterable {
        case text1 = "上記のいずれかをクリックすることで、"
        case term = "利用規約"
        case text2 = "及び"
        case privacyPolicy = "プライバシーポリシー"
        case text3 = "に同意するものとします"
    }
    
    private let textTypes: [TextType] = TextType.allCases
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var index: Int = 0
        var threeindex: Int = 0
        
        return ZStack(alignment: .topLeading) {
            ForEach(textTypes, id: \.self) { textType in
                self.text(for: textType)
                    .padding([.horizontal, .vertical], 0)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if textType == textTypes.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        
                        print(textType)
                    
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if textType == textTypes.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    
    func text(for textType: TextType) -> some View {
        baseText(textType: textType)
    }
    
    private func baseText(textType: TextType) -> Text {
        return Text(textType.rawValue)
            .font(.body)
            .foregroundColor(.orange)
    }
}

struct TermLabel3_Previews: PreviewProvider {
    static var previews: some View {
        TermLabel3()
    }
}
