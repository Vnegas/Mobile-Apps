//
//  fungicidas.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct fungicidas: View {
    @Binding var goToMenuFromHerb: Bool
    @State private var goToMenuFung = false
    @State private var goToFungArea = false
    @State private var goToFungPlanta = false

    var body: some View {
        GeometryReader { geometry in
            LazyVStack {
                // Screen Title
                HStack {
                    Image("icon_fung2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                        .offset(x: 10)
                    
                    Text("Fungicidas e Insecticidas")
                        .foregroundColor(.black)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.12))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(2)
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

                Spacer(minLength: geometry.size.height * 0.06)
                
                // Button to "Por área"
                NavigationLink(destination: fungicidas_area(goToFungicidasMenu: $goToMenuFung, goToHerbicidasMenu: $goToMenuFromHerb), isActive: $goToFungArea) {
                    Text("Por área")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.08) // Now scales dynamically
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05) // Keeps proportional rounding
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Button to "Por planta"
                NavigationLink(destination: fungicidas_planta(goToFungicidasMenu: $goToMenuFung, goToHerbicidasMenu: $goToMenuFung), isActive: $goToFungPlanta) {
                    Text("Por planta")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.08) // Now scales dynamically
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05) // Keeps proportional rounding
                }
                
                Spacer(minLength: geometry.size.height * 0.15)
                
                // "Atrás" Button
                NavigationLink(destination: menu(goToStart: $goToMenuFung), isActive: $goToMenuFung) {
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
    fungicidas(goToMenuFromHerb: .constant(false))
}
