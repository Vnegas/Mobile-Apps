//
//  ContentView.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct menu: View {
    @Binding var goToStart: Bool
    @State private var goToHerbicidas = false
    @State private var goToFungicidas = false
    @State private var goToDosificacion = false
    @State private var goBack = false
    @State private var goToAyuda = false

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
                    
                    VStack(spacing: geometry.size.height * 0.05) {
                        // Title
                        Text("Calibración")
                            .foregroundColor(.white)
                            .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.12))
                            .fontWeight(.bold)
                            .padding(.top, geometry.size.height * 0.12)

                        // Buttons
                        menuButton(title: "HERBICIDAS", icon: "icon_herb", isActive: $goToHerbicidas, destination: herbicidas(goToMenuFromHerb: $goToHerbicidas), geometry: geometry)

                        menuButton(title: "FUNGICIDAS E INSECTICIDAS", icon: "icon_fung2", isActive: $goToFungicidas, destination: fungicidas(goToMenuFromHerb: $goToHerbicidas), geometry: geometry)

                        menuButton(title: "DOSIFICACIÓN", icon: "icon_dosi", isActive: $goToDosificacion, destination: dosificacion(goToHerbicidasMenu: $goToHerbicidas), geometry: geometry)

                        Spacer(minLength: geometry.size.height * 0.1)

                        // Atras Button
                        HStack {
                            NavigationLink(destination: start(startBind: $goBack), isActive: $goBack) {
                                Text("ATRÁS")
                                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.06))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            // Help Button
                            NavigationLink(destination: ayuda(goToMenu: $goToAyuda), isActive: $goToAyuda) {
                                Text("AYUDA")
                                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.06))
                                    .foregroundColor(.black)
                            }
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

// Reusable button for menu items
func menuButton<Destination: View>(title: String, icon: String, isActive: Binding<Bool>, destination: Destination, geometry: GeometryProxy) -> some View {
    NavigationLink(destination: destination, isActive: isActive) {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width * 0.12, height: geometry.size.width * 0.1)
                .padding(.leading, geometry.size.width * 0.05)
            
            Text(title)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.06))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
        }
        .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.1)
        .background(
            RoundedRectangle(cornerRadius: 80)
                .fill(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 80).stroke(Color.accentColor, lineWidth: 4))
        )
    }
}

// Preview
#Preview {
    menu(goToStart: .constant(true))
}

// Allows color in hex code: "#373636"
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 17) & 0xFF, (int >> 4 * 17) & 0xFF, (int * 17) & 0xFF)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// FUENTES
// Cambria
// GlacialIndifference-Regular
// NotoSerifDisplay-ExtraCondensed
// NotoSerifDisplay-ExtraCondensedItalic
