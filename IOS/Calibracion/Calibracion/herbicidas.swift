//
//  herbicidas.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas: View {
    @Binding var goToMenuFromHerb: Bool
    @State private var goToMenuHerb = false
    @State private var goToHerbVel = false
    @State private var goToHerbVolFijo = false
    @State private var goToHerbVolApl = false

    var body: some View {
        GeometryReader { geometry in
            LazyVStack {
                // Screen Title
                HStack {
                    Image("icon_herb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                        .offset(x: 10)
                    
                    Text("Herbicidas")
                        .foregroundColor(.black)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.12))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: geometry.size.height * 0.05)
                
                // Instruction
                Text("Seleccione un método de calibración:")
                    .foregroundColor(.black)
                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.08))
                    .fontWeight(.bold)
                    .frame(maxWidth: geometry.size.width * 0.9)
                    .multilineTextAlignment(.center)

                Spacer(minLength: geometry.size.height * 0.04)
                
                // Button to "Volumen fijo"
                NavigationLink(destination: herbicidas_vol_fijo(goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToHerbVolFijo) {
                    Text("Volumen fijo")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Button to "Velocidad fija"
                NavigationLink(destination: herbicidas_vel_fija(goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToHerbVel) {
                    Text("Velocidad fija")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Button to "Volumen aplicado"
                NavigationLink(destination: herbicidas_vol_apl(goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToHerbVolApl) {
                    Text("Volumen aplicado")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.15)
                
                // "Atrás" Button
                NavigationLink(destination: menu(goToStart: $goToMenuHerb), isActive: $goToMenuHerb) {
                    Text("ATRÁS")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .foregroundColor(.black)
                        .frame(width: geometry.size.width - 70, height: 34, alignment: .leading)
                }

                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    herbicidas(goToMenuFromHerb: .constant(false))
}
