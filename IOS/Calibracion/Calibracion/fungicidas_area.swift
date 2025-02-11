//
//  fungicidas_area.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct fungicidas_area: View {
    // Navigation variables
    @Binding var goToFungicidasMenu: Bool
    @Binding var goToHerbicidasMenu: Bool
    @State private var goToHerbicidas = false
    @State private var goToFungicidas = false
    @State private var goToDosificacion = false
    
    // Input variables
    @State private var areaAplicada: Double? = nil
    @State private var volumenInicial: Double? = nil
    @State private var volumenFinal: Double? = nil
    @State private var areaCultivo: Double? = nil
    @State private var resultado: Double? = nil
    
    // State variables to control placeholder display
    @State private var showPlaceholder = [false, false, false, false]
    
    var body: some View {
        GeometryReader { geometry in
            LazyVStack {
                Spacer(minLength: geometry.size.height * 0.005)
                
                // Background & Title
                ZStack {
                    Image("method_title_bg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 2, height: geometry.size.height * 0.3)
                    
                    VStack {
                        Text("Área")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.08))
                            .foregroundColor(.black)
                        
                        Text("Marque un área conocida y aplique allí agua a la velocidad usual.")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.055))
                            .foregroundColor(Color(hex: "#373636"))
                            .frame(width: geometry.size.width * 0.9)
                            .multilineTextAlignment(.center)
                            .padding(.top, geometry.size.height * 0.01)
                    }
                }
                Spacer(minLength: geometry.size.height * 0.02)
                
                // Input fields
                inputField("Área aplicada (m", exponent: "2", value: $areaAplicada, placeholderIndex: 0, hint: "Área", width: geometry.size.width)
                inputField("Volumen inicial (litros", value: $volumenInicial, placeholderIndex: 1, hint: "Volumen", width: geometry.size.width)
                inputField("Volumen final (litros", value: $volumenFinal, placeholderIndex: 2, hint: "Volumen", width: geometry.size.width)
                inputField("Área del cultivo por aplicar (m", exponent: "2", value: $areaCultivo, placeholderIndex: 3, hint: "Área", width: geometry.size.width)
                
                Spacer(minLength: geometry.size.height * 0.03)
                HStack {
                    Spacer()
                    // Calculate button
                    Button(action: {
                        showPlaceholder = [
                            areaAplicada == nil,
                            volumenInicial == nil,
                            volumenFinal == nil,
                            areaCultivo == nil
                        ]
                        if !showPlaceholder.contains(true) {
                            resultado = ((volumenInicial ?? 0.0) - (volumenFinal ?? 0.0)) * (areaCultivo ?? 0.0) / (areaAplicada ?? 1.0)
                        } else {
                            resultado = nil
                        }
                    }) {
                        Text("Calcular")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
                            .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.06)
                            .foregroundColor(.black)
                            .background(Color.accentColor)
                            .cornerRadius(geometry.size.width * 0.05)
                    }
                    .padding(.top, geometry.size.height * 0.02)
                }
                
                Spacer(minLength: geometry.size.height * 0.02)
                
                // Show result
                result(resultado: resultado, width: geometry.size.width)
                
                Spacer(minLength: geometry.size.height * 0.025)
                
                // Navigation Menu
                navigationMenu(width: geometry.size.width, heigth: geometry.size.height)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "#F4F4F4"))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder
    func inputField(_ label: String, exponent: String = "", value: Binding<Double?>, placeholderIndex: Int, hint: String, width: CGFloat) -> some View {
        HStack {
            Text(label)
                .font(.custom("GlacialIndifference-Regular", size: width * 0.04))
                .foregroundColor(Color(hex: "#373636"))
            + Text(exponent)
                .baselineOffset(6.0)
                .font(.custom("GlacialIndifference-Regular", size: width * 0.03))
                .foregroundColor(Color(hex: "#373636"))
            + Text("):")
                .font(.custom("GlacialIndifference-Regular", size: width * 0.04))
                .foregroundColor(Color(hex: "#373636"))
            
            Spacer()
            
            TextField(showPlaceholder[placeholderIndex] ? "Agregar Dato" : "\(hint)", text: Binding(
                get: { value.wrappedValue != nil ? String(value.wrappedValue!) : "" },
                set: { newValue in
                    if let doubleValue = Double(newValue) {
                        value.wrappedValue = doubleValue
                        showPlaceholder[placeholderIndex] = false
                    } else if newValue.isEmpty {
                        value.wrappedValue = nil
                    }
                }
            ))
            .keyboardType(.numberPad)
            .font(.custom("GlacialIndifference-Regular", size: width * 0.04))
            .frame(width: width * 0.4, height: width * 0.1)
            .multilineTextAlignment(.center)
            .background {
                if #available(iOS 17.0, *) {
                    RoundedRectangle(cornerRadius: 65)
                        .fill(.white)
                        .stroke(.accent, lineWidth: 2)
                } else {
                    RoundedRectangle(cornerRadius: 65)
                        .fill(.white)
                        .border(.accent, width: 2)
                }
            }

        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
    }
    
    @ViewBuilder
    func result(resultado: Double?, width: CGFloat) -> some View {
        HStack {
            ZStack {
                Image("result_shape")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.33, height: width * 0.13)
                
                Text(resultado != nil ? "\(String(format: "%.3f", resultado!))" : "Resultado")
                    .font(.custom("GlacialIndifference-Regular", size: width * 0.059))
                    .foregroundColor(.black)
            }
            
            Text("litros")
                .font(.custom("GlacialIndifference-Regular", size: width * 0.059))
                .foregroundColor(.black)
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    func navigationMenu(width: CGFloat, heigth: CGFloat) -> some View {
        HStack {
            NavigationLink(destination: herbicidas(goToMenuFromHerb: $goToHerbicidasMenu), isActive: $goToHerbicidas) {
                Image("icon_herb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
            
            // Icon spacer / divider
            Image("icon_divider")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.1, height: heigth * 0.05)
            
            NavigationLink(destination: fungicidas(goToMenuFromHerb: $goToHerbicidasMenu), isActive: $goToFungicidas) {
                Image("icon_fung2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
            
            // Icon spacer / divider
            Image("icon_divider")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.1, height: heigth * 0.05)
            
            NavigationLink(destination: dosificacion(goToHerbicidasMenu: $goToHerbicidasMenu), isActive: $goToDosificacion) {
                Image("icon_dosi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
        }
    }
}

#Preview {
    fungicidas_area(goToFungicidasMenu: .constant(false), goToHerbicidasMenu: .constant(false))
}
