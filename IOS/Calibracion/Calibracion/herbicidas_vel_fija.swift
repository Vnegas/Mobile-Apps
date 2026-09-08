//
//  herbicidas_vel_fija.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2026 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas_vel_fija: View {
    // Navigation variable
    @Binding var path: NavigationPath
    
    // Input variables
    @State private var descarga: Double? = nil
    @State private var ancho: Double? = nil
    @State private var velocidad: Double? = nil
    @State private var resultado: Double? = nil
    
    // State variables to control placeholder display
    @State private var showPlaceholder = [false, false, false]
    // Spinner variable - toggle
    @State private var spinnerOpt: String = "m/s" // Default option
    // Spinner options
    private let units = ["m/s", "km/h"]
    
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
                Spacer(minLength: geometry.size.height * 0.08)
                ZStack {
                    Image("method_title_bg")
                        .resizable()
                        .frame(width: geometry.size.width * 2, height: geometry.size.height * 0.3)
                    VStack {
                        Text("Método de velocidad fija")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.07))
                            .foregroundColor(.black)
                        Text("Determina el volumen de caldo que se aplicará en una hectárea.")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
                            .foregroundColor(Color(hex: "#373636"))
                            .frame(width: geometry.size.width * 0.9, alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                }
                Spacer(minLength: geometry.size.height * 0.025)
                
                // Input fields
                inputField("Descarga en 1 minuto (litros):", value: createBinding(for: $descarga, placeholderIndex: 0), placeholderIndex: 0, hint: "Descarga", geometry: geometry)
                inputField("Ancho de franja o distancia entre boquillas (metros):", value: createBinding(for: $ancho, placeholderIndex: 1), placeholderIndex: 1, hint: "Distancia", geometry: geometry)
                inputField("Velocidad", value: createBinding(for: $velocidad, placeholderIndex: 2), placeholderIndex: 2, hint: "Velocidad", geometry: geometry)
                
                Spacer(minLength: geometry.size.height * 0.03)
                HStack {
                    Spacer()
                    Button(action: {
                        calculateResult()
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
        .onTapGesture {
            ocultarTeclado()
        }
    }
    
    @ViewBuilder
    func inputField(_ label: String, value: Binding<String>, placeholderIndex: Int, hint: String, geometry: GeometryProxy) -> some View {
        HStack {
            Text(label)
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.04))
                .foregroundColor(Color(hex: "#373636"))
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
            if placeholderIndex == 2 {
                Picker("m/s", selection: $spinnerOpt) {
                    ForEach(units, id: \.self) { unit in
                        Text(unit)
                            .tag(unit)
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.01))
                            .accentColor(.black)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.01))
                .accentColor(.black)
                .frame(width: geometry.size.width * 0.21)
                .onChange(of: spinnerOpt) { _ in
                    calculateResult()
                }
            }
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
    
    func calculateResult() {
        showPlaceholder = [
            descarga == nil,
            ancho == nil,
            velocidad == nil
        ]
        
        if !showPlaceholder.contains(true) {
            if spinnerOpt == "m/s" {
                let calculation = (((descarga ?? 0.0) * 10000) / ((velocidad ?? 1.0) * 60)) / (ancho ?? 1.0)
                resultado = calculation
            } else {
                let calculation = (((descarga ?? 0.0) * 10000) / (((velocidad ?? 1.0) / 3.6) * 60)) / (ancho ?? 1.0)
                resultado = calculation
            }
        } else {
            resultado = nil
        }
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
    //herbicidas_vel_fija(goToHerbicidasMenu: .constant(false))
}
