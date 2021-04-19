//
//  ItemView.swift
//  PinterestLikeUI
//
//  Created by 鶴本賢太朗 on 2021/04/19.
//

import SwiftUI

struct ItemView: View {
    let content: String
    
    let color: Color = Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1)
    
    let width: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            photoBg
                .frame(width: width)

            contentLabel
                .frame(width: width)
        }
        .cornerRadius(20)
    }
    
    private var photoBg: some View {
        Color.gray
            .frame(height: 100)
    }
    
    private var contentLabel: some View {
        Text(content)
            .lineLimit(8)
            .padding()
            .frame(width: 200)
            .background(color)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(content: "ここで俺は人生で一番美味いラーメン屋に出会った\nここで俺は人生で一番美味いラーメン屋に出会った\nここで俺は人生で一番美味いラーメン屋に出会った", width: 200)
    }
}
