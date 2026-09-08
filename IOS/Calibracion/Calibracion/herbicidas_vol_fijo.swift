//
//  herbicidas_vol_fijo.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas_vol_fijo: View {
    // Navigation variable
    @Binding var path: NavigationPath
    
    // Input variables
    @State private var descarga: Double? = nil
    @State private var ancho: Double? = nil
    @State private var volumen: Double? = nil
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
                Spacer(minLength: geometry.size.height * 0.059)
                
                ZStack {
                    Image("method_title_bg")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.29)
                    VStack {
                        Text("Método del volumen fijo")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.065))
                            .foregroundColor(.black)
                        Text("Determina a qué velocidad se debe avanzar para aplicar el volumen de caldo deseado.")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                            .foregroundColor(Color(hex: "#373636"))
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Input fields
                inputField("Descarga por boquilla en 1 minuto (litros):", value: createBinding(for: $descarga, placeholderIndex: 0), placeholderIndex: 0, hint: "Descarga", geometry: geometry)
                inputField("Ancho de franja o distancia entre boquillas (metros):", value: createBinding(for: $ancho, placeholderIndex: 1), placeholderIndex: 1, hint: "Distancia", geometry: geometry)
                inputField("Volumen de aplicación por hectárea (litros):", value: createBinding(for: $volumen, placeholderIndex: 2), placeholderIndex: 2, hint: "Volumen", geometry: geometry)
                
                Spacer(minLength: geometry.size.height * 0.035)
                
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
                
                Spacer(minLength: geometry.size.height * 0.028)
                
                result(resultado: resultado, geometry: geometry)
                
                Spacer(minLength: geometry.size.height * 0.038)
                
                navigationMenu(width: geometry.size.width, height: geometry.size.height)
                Spacer(minLength: geometry.size.height * 0.001)
            }
        }
        .background(Color(hex: "#F4F4F4"))
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
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
            
            Picker("m/s", selection: $spinnerOpt) {
                ForEach(units, id: \.self) { unit in
                    Text(unit)
                        .tag(unit)
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
                        .accentColor(.black)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
            .accentColor(.black)
            .frame(width: geometry.size.width * 0.21)
            .onChange(of: spinnerOpt) { _ in
                calculateResult()
            }
        }
    }
    
    func calculateResult() {
        showPlaceholder = [
            descarga == nil,
            ancho == nil,
            volumen == nil
        ]
        
        if !showPlaceholder.contains(true) {
            var calculation = ((10000 / (ancho ?? 1.0)) / ((volumen ?? 0.0) / (descarga ?? 1.0))) / 60
            if spinnerOpt == "km/h" {
                calculation = calculation * 3.6
            }
            resultado = calculation
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
    //herbicidas_vol_fijo(goToHerbicidasMenu: .constant(false))
}
