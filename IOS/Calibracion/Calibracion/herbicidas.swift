//
//  herbicidas.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas: View {
    @Binding var path: NavigationPath

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
                Button(action: {
                    path.append(AppRoute.herbicidasVolFijo)
                }){
                    Text("Volumen fijo")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Button to "Velocidad fija"
                Button(action: {
                    path.append(AppRoute.herbicidasVelFija)
                }){
                    Text("Velocidad fija")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Button to "Volumen aplicado"
                Button(action: {
                    path.append(AppRoute.herbicidasVolAplic)
                }){
                    Text("Volumen aplicado")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.15)
                
                // "Atrás" Button
                Button(action: {
                    path.removeLast()
                }) {
                    Text("ATRÁS")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 35)
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
    //herbicidas(path: )
}
