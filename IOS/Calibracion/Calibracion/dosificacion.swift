//
//  dosificacion.swift
//  Calibracion
//
//  Created by vnegas on 17/11/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct dosificacion: View {
    // Navigation variable
    @Binding var path: NavigationPath
    
    // Input variables
    @State private var volumen: Double? = nil
    @State private var dosis: Double? = nil
    @State private var area: Double? = nil
    // Result variables
    @State private var resultado1: Double? = nil
    @State private var resultado2: Double? = nil
    @State private var resultado3: Double? = nil
    
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
                let normalizedValue = newValue.replacingOccurrences(of: ",", with: ".")
                
                if let doubleValue = Double(normalizedValue) {
                    input.wrappedValue = doubleValue
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
                Spacer(minLength: geometry.size.height * 0.06)
                HStack {
                    Image("icon_dosi")
                        .resizable()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.09)
                    Text("Dosificación")
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.09))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
                Spacer(minLength: geometry.size.height * 0.025)
                
                // Input fields
                inputField("Volumen de aplicación (l/ha", value: createBinding(for: $volumen, placeholderIndex: 0), placeholderIndex: 0, hint: "Volumen", geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.015)
                inputField("Dosis de PC por ha (litros", value: createBinding(for: $dosis, placeholderIndex: 1), placeholderIndex: 1, hint: "Dosis", geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.02)
                
                result("Resultado: PC (ml) por litro de agua", resultado: resultado1, geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.03)
                
                inputField("Área por aplicar (m", exponent: "2", value: createBinding(for: $area, placeholderIndex: 2), placeholderIndex: 2, hint: "Área", geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.02)
                
                result("Resultado: Agua necesaria (litros)", resultado: resultado2, geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.015)
                result("Resultado: PC (ml) por área", resultado: resultado3, geometry: geometry)
                
                Spacer(minLength: geometry.size.height * 0.05)
                HStack {
                    Text("PC = Producto Comercial\nl/ha = litros por hectárea")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                        .frame(alignment: .center)
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        showPlaceholder = [
                            volumen == nil,
                            dosis == nil,
                            area == nil
                        ]
                        if showPlaceholder.contains(true) {
                            let calculation1 = ((dosis ?? 0.0) / (volumen ?? 1.0)) * 1000
                            resultado1 = calculation1
                            
                            let calculation2 = ((volumen ?? 0.0) * (area ?? 0.0)) / 10000
                            resultado2 = calculation2
                            
                            let calculation3 = (((dosis ?? 0.0) * (area ?? 0.0)) / 10000) * 1000
                            resultado3 = calculation3
                        } else {
                            resultado1 = nil
                            resultado2 = nil
                            resultado3 = nil
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
                Spacer(minLength: geometry.size.height * 0.05)
                
                navigationMenu(width: geometry.size.width, height: geometry.size.height)
                Spacer(minLength: geometry.size.height * 0.01)
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
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.046))
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
                .keyboardType(.decimalPad)
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
    func result(_ label: String, resultado: Double?, geometry: GeometryProxy) -> some View {
        HStack {
            Text(label)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .fontWeight(.bold)
            Spacer()
            ZStack {
                Image("result_shape")
                    .resizable()
                    .frame(width: geometry.size.width * 0.34, height: geometry.size.height * 0.07)
                Text(resultado != nil ? "\(formatNumber(resultado!))" : "Resultado")
                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.048))
                    .frame(width: geometry.size.width * 0.26, height: 36.4)
                    .foregroundColor(.black)
            }
        }
        .padding(.trailing, 16)
    }
    
    private func goToMenu(_ destination: AppRoute) {
        // Remove everything ABOVE Main Menu.
        // Main Menu is the first item in the path.
        if path.count > 1 {
            path.removeLast(path.count - 1)
        }

        // Add the selected menu
        path.append(destination)
    }

    @ViewBuilder
    func navigationMenu(width: CGFloat, height: CGFloat) -> some View {
        HStack {
            Button(action: {
                goToMenu(.herbicidas)
            })
            {
                Image("icon_herb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
            
            Image("icon_divider")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.1, height: height * 0.05)
            
            Button(action: {
                goToMenu(.fungicidas)
            })
            {
                Image("icon_fung2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
            
            Image("icon_divider")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.1, height: height * 0.05)
            
            Button(action: {
                goToMenu(.dosificacion)
            })
            {
                Image("icon_dosi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
        }
    }
}

#Preview {
    //dosificacion(goToHerbicidasMenu: .constant(false))
}
