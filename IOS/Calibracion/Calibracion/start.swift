//
//  start.swift
//  Calibracion
//
//  Created by vnegas on 15/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct start: View {
    @Binding var startBind: Bool
    @State private var goToStart = false
    @State private var showPopup = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer(minLength: geometry.size.height * 0.02)
                    
                    // UCR logo
                    Image("ucr_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.2)
                    
                    Spacer(minLength: geometry.size.height * 0.03)
                    
                    // EEAFBM logo
                    Image("eeafb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.1)
                    
                    Spacer(minLength: geometry.size.height * 0.05)
                    
                    // App title
                    Text("Calibración")
                        .foregroundColor(.black)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.11))
                        .fontWeight(.bold)
                    
                    Spacer(minLength: geometry.size.height * 0.02)
                    
                    // App version
                    Text("V1.0")
                        .foregroundColor(.black)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.08))
                        .fontWeight(.bold)
                    
                    Spacer(minLength: geometry.size.height * 0.25)
                    
                    // Enter app button
                    NavigationLink(destination: menu(goToStart: $goToStart), isActive: $goToStart) {
                        Text("Entrar")
                            .foregroundColor(.black)
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.09))
                            .tracking(15)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                            .background(Color.accentColor)                    }
                    
                    //Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .overlay(
                    PopupView(showPopup: $showPopup, geometry: geometry)
                        .opacity(showPopup ? 1 : 0)
                )
                .onAppear {
                    showPopup = true
                }
            }
            .navigationViewStyle(StackNavigationViewStyle()) // Ensures full screen on iPad
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Popup
struct PopupView: View {
    @Binding var showPopup: Bool
    let geometry: GeometryProxy
    
    var body: some View {
        VStack {
            Spacer(minLength: geometry.size.height * 0.02)
            
            Text("ADVERTENCIA")
                .foregroundColor(.red)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
            
            Spacer(minLength: geometry.size.height * 0.02)
            
            HStack {
                Spacer(minLength: geometry.size.width * 0.05)
                Text("""
                Descargo de responsabilidad:
                El uso de la aplicación móvil Calibración y sus resultados corre por cuenta y riesgo propio del usuario. 
                La Universidad de Costa Rica no asumirá ninguna responsabilidad por cualquier pérdida o daño causado por el uso o la información generada en esta aplicación.
                """)
                .foregroundColor(.black)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.04))
                .multilineTextAlignment(.center)
                Spacer(minLength: geometry.size.width * 0.05)
            }
            
            Spacer(minLength: geometry.size.height * 0.02)
            
            // Accept Button
            Button(action: { showPopup = false }) {
                Text("Aceptar")
                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.07)
                    .foregroundColor(.accentColor)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.accentColor, lineWidth: 2))
                    )
            }
            .padding(.bottom, geometry.size.height * 0.02)
        }
        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.6)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    start(startBind: .constant(true))
}
