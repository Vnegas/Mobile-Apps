//
//  fungicidas.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct fungicidas: View {
    @Binding var path: NavigationPath

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
                Button(action: {
                    path.append(AppRoute.fungicidasArea)
                }){
                    Text("Por área")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.08)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(geometry.size.width * 0.05)
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Button to "Por planta"
                Button(action: {
                    path.append(AppRoute.fungicidasPlanta)
                }){
                    Text("Por planta")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.08)
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
    //fungicidas(path: )
}
