//
//  herbicidas.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas: View {
    @Binding var goToMenuFromHerb: Bool
    @State private var goToMenuHerb = false
    @State private var goToHerbVel = false
    @State private var goToHerbVolFijo = false
    @State private var goToHerbVolApl = false
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
            Spacer(minLength: 50)
            // Instruction
            Text("Seleccione un método de calibración:")
                .foregroundColor(.black)
                .font(.custom("GlacialIndifference-Regular", size: 28.6))
                .fontWeight(.bold)
                .frame(width: 338, height: 76, alignment: .center)
                .multilineTextAlignment(.center)
            Spacer(minLength: 40)
            // Button to VolumenFijo
            NavigationLink(destination: herbicidas_vol_fijo(goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToHerbVolFijo) {
                Text("Volumen fijo")
                    .font(.custom("GlacialIndifference-Regular", size: 27.3))
                    .frame(width: 286, height: 72, alignment: .center)
                    .foregroundColor(.black)
                    .background(.accent)
                    .cornerRadius(20)
            }
            Spacer(minLength: 30)
            // Button to VelocidadFija
            NavigationLink(destination: herbicidas_vel_fija(goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToHerbVel) {
                Text("Velocidad fija")
                    .font(.custom("GlacialIndifference-Regular", size: 27.3))
                    .frame(width: 286, height: 72, alignment: .center)
                    .foregroundColor(.black)
                    .background(.accent)
                    .cornerRadius(20)
            }
            Spacer(minLength: 30)
            // Button to VolumenAplicado
            NavigationLink(destination: herbicidas_vol_apl(goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToHerbVolApl) {
                Text("Volumen aplicado")
                    .font(.custom("GlacialIndifference-Regular", size: 27.3))
                    .frame(width: 286, height: 72, alignment: .center)
                    .foregroundColor(.black)
                    .background(.accent)
                    .cornerRadius(20)
            }
            Spacer(minLength: 74)
            // Button to go back
            NavigationLink(destination: menu(goToStart: $goToMenuHerb), isActive: $goToMenuHerb) {
                Text("ATRÁS")
                    .font(.custom("GlacialIndifference-Regular", size: 28.6))
                    .foregroundColor(.black)
                    .frame(width: screenWidth - 70, height: 34, alignment: .leading)
            }
            // Default back button disabled
            .navigationBarBackButtonHidden(true)
        }.background(.white)
    }
}

#Preview {
    //herbicidas()
}
