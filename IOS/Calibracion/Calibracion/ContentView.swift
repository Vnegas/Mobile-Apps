//
//  ContentView.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct menu: View {
    @Binding var goToStart: Bool
    @State private var goToHerbicidas = false
    @State private var goToFungicidas = false
    @State private var goToDosificacion = false
    let screenWidth = UIScreen.main.bounds.size.width;
    var body: some View {
        NavigationView {
            ZStack {
                Image("menu_bg")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: /*@START_MENU_TOKEN@*/500.0/*@END_MENU_TOKEN@*/, height: 980.0)
                    
                LazyVStack {
                    // Title
                    Text("Calibración")
                        .foregroundColor(.white)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 57.2))
                        .fontWeight(.bold)
                        .padding()
                    Spacer(minLength: 50)
                    // Button to Herbicidas
                    NavigationLink(destination: herbicidas(goToMenuFromHerb: $goToHerbicidas), isActive: $goToHerbicidas) {
                        // Herbicidas icon
                        Image("icon_herb")
                            .resizable(resizingMode: .stretch)
                            .offset(x: 20)
                            .frame(width: 50.4, height: 43.9)
                        
                        Text("HERBICIDAS")
                            .font(.custom("GlacialIndifference-Regular", size: 31.2))
                            .padding(.trailing, 18.0)
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    Spacer(minLength: 30)
                    // Button to Fungicidas
                    NavigationLink(destination: fungicidas(goToMenuFromHerb: $goToHerbicidas), isActive: $goToFungicidas) {
                        // Herbicidas icon
                        Image("icon_fung2")
                            .resizable(resizingMode: .stretch)
                            .offset(x: 20)
                            .frame(width: 44.4, height: 40.9)
                        
                        Text("FUNGICIDAS E INSECTICIDAS")
                            .font(.custom("GlacialIndifference-Regular", size: 31.2))
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    Spacer(minLength: 30)
                    // Button to Dosificacion
                    NavigationLink(destination: dosificacion(goToHerbicidasMenu: $goToHerbicidas), isActive: $goToDosificacion) {
                        // Herbicidas icon
                        Image("icon_dosi")
                            .resizable(resizingMode: .stretch)
                            .offset(x: 20)
                            .frame(width: 44.4, height: 40.9)
                        
                        Text("DOSIFICACIÓN")
                            .font(.custom("GlacialIndifference-Regular", size: 31.2))
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    Spacer(minLength: 70)
                    HStack {
                        // Button to go back
                        Text("ATRÁS")
                            .font(.custom("GlacialIndifference-Regular", size: 28.6))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                goToStart = false
                            }
                        Spacer(minLength: 5)
                        // Button to go to Youtube video for help
                        Link("AYUDA", destination: URL(string: "https://www.youtube.com/watch?v=ufisItmEEpU&ab_channel=Malezas%26Arvenses")!)
                            .font(.custom("GlacialIndifference-Regular", size: 28.6))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.trailing)
                    }.frame(width: screenWidth - 80, height: 34)
                    Spacer()
                }
            }
        }
        // Default back button disabled
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    //menu()
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
