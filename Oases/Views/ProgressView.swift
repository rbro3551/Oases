//
//  ProgressView.swift
//  Oases
//
//  Created by Riley Brookins on 7/5/23.
//

import SwiftUI

struct ProgressView: View {
    let progress: Double
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: 30
                )
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                    
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: 0.25, color: Color.pink)
    }
}
