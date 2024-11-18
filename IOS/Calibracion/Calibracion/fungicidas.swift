//
//  fungicidas.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct fungicidas: View {
    @Binding var goToMenuFromHerb: Bool
    @State private var goToMenuFung = false
    @State private var goToFungArea = false
    @State private var goToFungPlanta = false
    
    let screenWidth = UIScreen.main.bounds.size.width;
    
    var body: some View {
        LazyVStack {
            // Screen Title
            HStack {
                // Herbicidas icon
                Image("icon_fung2")
                    .resizable(resizingMode: .stretch)
                    .offset(x: 10)
                    .frame(width: 59.8, height: 59.8)
                // Title
                Text("Fungicidas e Insecticidas")
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
            Spacer(minLength: 60)
            // Button to VolumenFijo
            NavigationLink(destination: fungicidas_area(goToFungicidasMenu: $goToMenuFung, goToHerbicidasMenu: $goToMenuFromHerb, goToDosificacionM: $goToMenuFung), isActive: $goToFungArea) {
                Text("Por área")
                    .font(.custom("GlacialIndifference-Regular", size: 28.6))
                    .frame(width: 182, height: 72, alignment: .center)
                    .foregroundColor(.black)
                    .background(.accent)
                    .cornerRadius(20)
            }
            Spacer(minLength: 30)
            // Button to VelocidadFija
            NavigationLink(destination: fungicidas_planta(goToFungicidasMenu: $goToMenuFung, goToHerbicidasMenu: $goToMenuFung), isActive: $goToFungPlanta) {
                Text("Por planta")
                    .font(.custom("GlacialIndifference-Regular", size: 28.6))
                    .frame(width: 182, height: 72, alignment: .center)
                    .foregroundColor(.black)
                    .background(.accent)
                    .cornerRadius(20)
            }
            Spacer(minLength: 90)
            // Button to go back
            NavigationLink(destination: menu(goToStart: $goToMenuFung), isActive: $goToMenuFung) {
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
    //fungicidas()
}
