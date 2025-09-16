//
//  herbicidas_vol_apl.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas_vol_apl: View {
    // Navigation variables
    @Binding var goToHerbicidasMenu: Bool
    
    // Input variables
    @State private var area: Double? = nil
    @State private var volI: Double? = nil
    @State private var volF: Double? = nil
    @State private var resultado: Double? = nil
    
    // State variables to control placeholder display
    @State private var showPlaceholder = [false, false, false]
    
    // Function to bind input variables
    private func createBinding(for input: Binding<Double?>, placeholderIndex: Int) -> Binding<String> {
        Binding(
            get: {
                if let value = input.wrappedValue {
                    return String(value)
                } else {
                    return ""
                }
            },
            set: { newValue in
                if let intValue = Double(newValue) {
                    input.wrappedValue = intValue
                    showPlaceholder[placeholderIndex] = false
                } else if newValue.isEmpty {
                    input.wrappedValue = nil
                }
            }
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
            LazyVStack {
                Spacer(minLength: geometry.size.height * 0.005)
                ZStack {
                    Image("method_title_bg")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    VStack {
                        Text("Método del volumen\naplicado en un área\nconocida")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.065))
                            .foregroundColor(.black)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        Text("Determina el volumen de aplicación por hectárea. Marque un área conocida y aplique allí agua a la velocidad usual.")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                            .foregroundColor(Color(hex: "#373636"))
                            .frame(width: geometry.size.width * 0.9, alignment: .center)
                    }
                }
                Spacer(minLength: geometry.size.height * 0.04)
                
                // Input fields
                inputField("Área aplicada (m", exponent: "2", value: createBinding(for: $area, placeholderIndex: 0), placeholderIndex: 0, hint: "Área", geometry: geometry)
                inputField("Volumen inicial (litros", value: createBinding(for: $volI, placeholderIndex: 1), placeholderIndex: 1, hint: "Volumen", geometry: geometry)
                inputField("Volumen final (litros", value: createBinding(for: $volF, placeholderIndex: 2), placeholderIndex: 2, hint: "Volumen", geometry: geometry)
                
                Spacer(minLength: geometry.size.height * 0.04)
                HStack {
                    Spacer()
                    Button(action: {
                        showPlaceholder = [
                            area == nil,
                            volI == nil,
                            volF == nil
                        ]
                        
                        if !showPlaceholder.contains(true) {
                            let calculation = (((volI ?? 0.0) - (volF ?? 0.0)) * 10000) / (area ?? 1.0)
                            resultado = calculation
                        } else {
                            resultado = nil
                        }
                        ocultarTeclado()
                    }) {
                        Text("Calcular")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.06)
                            .foregroundColor(.black)
                            .background(Color.accentColor)
                            .cornerRadius(geometry.size.width * 0.05)
                    }
                }
                .padding(.horizontal, geometry.size.width * 0.05)
                Spacer(minLength: geometry.size.height * 0.03)
                
                result(resultado: resultado, geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.04)
                
                navigationMenu(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .background(Color(hex: "#F4F4F4"))
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            ocultarTeclado()
        }
    }
    
    @ViewBuilder
    func inputField(_ label: String, exponent: String = "", value: Binding<String>, placeholderIndex: Int, hint: String, geometry: GeometryProxy) -> some View {
        HStack {
            Text(label)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.04))
                .foregroundColor(Color(hex: "#373636"))
            + Text(exponent)
                .baselineOffset(geometry.size.width * 0.008)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.025))
                .foregroundColor(Color(hex: "#373636"))
            + Text("):")
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.04))
                .foregroundColor(Color(hex: "#373636"))
            Spacer()
            TextField(showPlaceholder[placeholderIndex] ? "Agregar Dato" : "\(hint)", text: value)
                .keyboardType(.numberPad)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.04))
                .foregroundColor(showPlaceholder[placeholderIndex] ? Color(hex: "#68FF0000") : Color(hex: "#373636"))
                .multilineTextAlignment(.center)
                .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.06)
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
        .padding(.top, 10)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
    
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        
        if abs(number) < 0.001 && number != 0 {
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 3
        }
        
        if number == floor(number) {
            formatter.maximumFractionDigits = 0
        }
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    @ViewBuilder
    func result(resultado: Double?, geometry: GeometryProxy) -> some View {
        HStack {
            ZStack {
                Image("result_shape")
                    .resizable()
                    .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.1)
                Text(resultado != nil ? "\(formatNumber(resultado!))" : "Resultado")
                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.059))
                    .foregroundColor(.black)
            }
            Text("litros/ha")
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.059))
                .foregroundColor(.black)
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    func navigationMenu(width: CGFloat, height: CGFloat) -> some View {
        HStack {
            NavigationLink(destination: herbicidas(goToMenuFromHerb: $goToHerbicidasMenu)) {
                Image("icon_herb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
            
            Image("icon_divider")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.1, height: height * 0.05)
            
            NavigationLink(destination: fungicidas(goToMenuFromHerb: $goToHerbicidasMenu)) {
                Image("icon_fung2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
            
            Image("icon_divider")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.1, height: height * 0.05)
            
            NavigationLink(destination: dosificacion(goToHerbicidasMenu: $goToHerbicidasMenu)) {
                Image("icon_dosi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    herbicidas_vol_apl(goToHerbicidasMenu: .constant(false))
}
