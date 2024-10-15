//
//  start.swift
//  Calibracion
//
//  Created by vnegas on 15/10/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct start: View {
    @State private var goToStart = false
    @State private var showPopup = false
    let screenWidth = UIScreen.main.bounds.size.width;
    
    var body: some View {
        NavigationView {
            LazyVStack {
                // UCR logo
                Spacer(minLength: 20)
                Image("ucr_logo")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 204, height: 184)
                Spacer(minLength: 30)
                // EEAFBM logo
                Image("eeafb")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 316, height: 90)
                Spacer(minLength: 50)
                // App title
                Text("Calibración")
                    .foregroundColor(.black)
                    .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 44.4))
                    .fontWeight(.bold)
                Spacer(minLength: 20)
                // App version
                Text("V1.0")
                    .foregroundColor(.black)
                    .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 41.4))
                    .fontWeight(.bold)
                Spacer(minLength: 205)
                // Enter app
                NavigationLink(destination: menu(goToStart: $goToStart), isActive: $goToStart) {
                    Text("Entrar")
                        .foregroundColor(.black)
                        .font(.custom("GlacialIndifference-Regular", size: 35))
                        .tracking(10)
                        .frame(width: screenWidth, height: 92, alignment: .center)
                        .background(.accent)
                }
            }
        }
        // Default back button disabled
        .navigationBarBackButtonHidden(true)
        // Show popup
        .onAppear {
            showPopup = true
        }
        .overlay(
            PopupView(showPopup: $showPopup)
                .opacity(showPopup ? 1 : 0)
        )
    }
}

// Popup
struct PopupView: View {
    @Binding var showPopup: Bool
    
    var body: some View {
        VStack {
            // Popup title
            Spacer(minLength: 20)
            Text("ADVERTENCIA")
                .foregroundColor(.red)
                .font(.custom("GlacialIndifference-Regular", size: 28.4))
            Spacer(minLength: 20)
            // Descargo de responsabilidad
            HStack {
                Spacer(minLength: 20)
                Text("Descargo de responsabilidad\nEl uso de la aplicación móvil calibración y sus resultados corre por cuenta y riesgo propio del usuario. La Universidad de Costa Rica no asumirá ninguna responsabilidad por cualquier pérdida o daño por el uso o la información generada de la aplicación móvil Calibración.")
                    .foregroundColor(.black)
                    .font(.custom("GlacialIndifference-Regular", size: 20.4))
                Spacer(minLength: 20)
            }
            Spacer(minLength: 20)
            // Button to accept and dismissed popup
            HStack {
                Spacer()
                Button(action: {showPopup = false} ) {
                    Text("Aceptar")
                        .font(.custom("GlacialIndifference-Regular", size: 25.2))
                        .frame(width: 110, height: 50, alignment: .center)
                        .foregroundColor(.accent)
                        .cornerRadius(80)
                        .background {
                            RoundedRectangle(cornerRadius: 80)
                                .fill(.white)
                                .stroke(.accent, lineWidth: 2)
                        }
                }
                .padding(.trailing, 10)
            }
            Spacer(minLength: 5)
        }
        .frame(width: 380, height: 370)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

#Preview {
    start()
}
