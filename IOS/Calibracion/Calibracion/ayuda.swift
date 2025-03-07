//
//  ayuda.swift
//  Calibracion
//
//  Created by vnegas on 6/3/25.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct ayuda: View {
    @Binding var goToMenu: Bool
    @State private var goBack = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Background Image
                    Image("menu_bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height * 1.2)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer(minLength: geometry.size.height * 0.2)
                        
                        // Buttons
                        Link("POLÍTICAS DE PRIVACIDAD", destination: URL(string: "https://arvenses-eeafbm.ucr.ac.cr/index.php/es/politicas-de-privacidad/calibracion-politicas-de-privacidad")!)
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.06))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.13)
                            .background(
                                RoundedRectangle(cornerRadius: 80)
                                    .fill(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 80).stroke(Color.accentColor, lineWidth: 4))
                            )
                        
                        Spacer()
                            .frame(height: geometry.size.height * 0.08)
                        
                        Link("AYUDA", destination: URL(string: "https://www.youtube.com/watch?v=ufisItmEEpU&ab_channel=Malezas%26Arvenses")!)
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.06))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.1)
                            .background(
                                RoundedRectangle(cornerRadius: 80)
                                    .fill(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 80).stroke(Color.accentColor, lineWidth: 4))
                            )

                        Spacer(minLength: geometry.size.height * 0.2)
                        
                        HStack {
                            NavigationLink(destination: menu(goToStart: $goBack), isActive: $goBack) {
                                Text("ATRÁS")
                                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.06))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, geometry.size.width * 0.1)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, geometry.size.height * 0.27)
                }
            }
        }
        .navigationViewStyle(.stack) // Forces full-screen mode on iPad
        .navigationBarBackButtonHidden(true)
    }
}


// Preview
#Preview {
    ayuda(goToMenu: .constant(true))
}

// FUENTES
// Cambria
// GlacialIndifference-Regular
// NotoSerifDisplay-ExtraCondensed
// NotoSerifDisplay-ExtraCondensedItalic
