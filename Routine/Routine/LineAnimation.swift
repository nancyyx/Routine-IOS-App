//
//  LineAnimation.swift
//  Routine
//
//  Created by Dajun Xian on 11/17/22.
//

import SwiftUI

struct LineAnimation: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LineAnimation_Previews: PreviewProvider {
    let timer = Timer.publish(every: 0.02, on: .main, in:
            .common).autoconnect()
    static var previews: some View {
        LineAnimation()
    }
}
