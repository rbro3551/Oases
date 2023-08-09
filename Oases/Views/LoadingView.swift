//
//  LoadingView.swift
//  Oases
//
//  Created by Riley Brookins on 8/8/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(width: 100, height: 125)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))


    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
