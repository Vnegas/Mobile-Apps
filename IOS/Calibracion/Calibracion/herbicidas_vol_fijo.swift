//
//  herbicidas_vol_fijo.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas_vol_fijo: View {
    //@Binding var goToMenu: Bool
    let screenWidth = UIScreen.main.bounds.size.width;
    
    var body: some View {
        LazyVStack {
            // Screen Title
            HStack {
                // Herbicidas icon
                Image("icon_herb")
                    .resizable(resizingMode: .stretch)
                    .offset(x: 10)
                    .frame(width: 59.8, height: 59.8)
                // Title
                Text("Herbicidas")
                    .foregroundColor(.black)
                    .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 49.4))
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    //herbicidas_vol_fijo()
}
