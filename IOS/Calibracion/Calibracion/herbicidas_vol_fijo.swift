//
//  herbicidas_vol_fijo.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas_vol_fijo: View {
    let screenWidth = UIScreen.main.bounds.size.width;
    
    // Navigation variables
    @Binding var goToHerbicidasMenu: Bool
    @State private var goToHerbicidas = false
    @State private var goToFungicidas = false
    @State private var goToDosificacion = false
    
    // Input variables
    @State private var descarga: Double? = nil
    @State private var ancho: Double? = nil
    @State private var volumen: Double? = nil
    @State private var resultado: Double? = nil
    
    // State variables to control placeholder display - See if input is already introduced
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
                if let intValue = Double(newValue) {
                    input.wrappedValue = intValue
                    showPlaceholder[placeholderIndex] = false // Reset placeholder on valid input
                } else if newValue.isEmpty {
                    input.wrappedValue = nil
                }
            }
        )
    }
    
    var body: some View {
        LazyVStack {
            Spacer(minLength: 50)
            ZStack {
                Image("method_title_bg")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 500, height: 180)
                VStack {
                    // Screen Title
                    Spacer(minLength: 40)
                    Text("Método del volumen fijo")
                        .font(.custom("GlacialIndifference-Regular", size: 34))
                        .foregroundColor(.black)
                    // Method description
                    Spacer(minLength: 15)
                    Text("Determina a qué velocidad se debe avanzar para aplicar el volumen de caldo deseado.")
                        .font(.custom("GlacialIndifference-Regular", size: 24))
                        .foregroundColor(Color(hex: "#373636"))
                        .frame(width: 364, height: 120, alignment: .center)
                        .multilineTextAlignment(.center)
                }
            }
            Spacer(minLength: 32)
            
            // First input
            inputField("Descarga por boquilla en 1 minuto (litros):", value: createBinding(for: $descarga, placeholderIndex: 0), placeholderIndex: 0, hint: "Descarga")
            Spacer(minLength: 15)
            // Second input
            inputField("Ancho de franja o distancia entre boquillas (metros):", value: createBinding(for: $ancho, placeholderIndex: 1), placeholderIndex: 1, hint: "Distancia")
            Spacer(minLength: 15)
            // Third input
            inputField("Volumen de aplicación por hectárea (litros):", value: createBinding(for: $volumen, placeholderIndex: 2), placeholderIndex: 2, hint: "Volumen")
            
            // Calculate button
            Spacer(minLength: 30)
            HStack {
                Spacer() // Pushes the text to the right
                Button(action: {
                    calculateResult()
                }) {
                    Text("Calcular")
                        .font(.custom("GlacialIndifference-Regular", size: 20.6))
                        .frame(width: 128, height: 57.2, alignment: .center)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(20)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing) // Aligns HStack to the right side of the screen
            .padding()
            Spacer(minLength: 30)
            
            // Show result
            result(resultado: resultado)
            Spacer(minLength: 40)
            
            navigationMenu()
            Spacer(minLength: 15)
            
            .navigationBarBackButtonHidden(true)
        } // LazyVStack
        .background(Color(hex: "#F4F4F4"))
        .edgesIgnoringSafeArea(.all) // Fills all screen
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // Body
    
    @ViewBuilder
    func inputField(_ label: String, exponent: String = "", value: Binding<String>, placeholderIndex: Int, hint: String) -> some View {
        HStack {
            Text(label)
                .font(.custom("GlacialIndifference-Regular", size: 20.6))
                .foregroundColor(Color(hex: "#373636"))
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
            Spacer()
            TextField(showPlaceholder[placeholderIndex] ? "Agregar Dato" : "\(hint)", text: value)
                .keyboardType(.numberPad)
                .font(.custom("GlacialIndifference-Regular", size: 19))
                .foregroundColor(showPlaceholder[placeholderIndex] ? Color(hex: "#68FF0000") : Color(hex: "#373636"))
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 47, alignment: .center)
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
        } // HStack
        .padding(.top, 10)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    } // InputField
    
    // Decimal format
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        
        // Default style
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        
        // Scientific notation for very small numbers
        if abs(number) < 0.001 && number != 0 {
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 3
        }
        
        // Remove decimals for integers
        if number == floor(number) {
            formatter.maximumFractionDigits = 0
        }
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    } // decimal format
    
    @ViewBuilder
    func result(resultado: Double?) -> some View {
        HStack {
            ZStack {
                Image("result_shape")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 208, height: 65)
                Text(resultado != nil ? "\(formatNumber(resultado!))" : "Resultado")
                    .font(.custom("GlacialIndifference-Regular", size: 28.6))
                    .frame(width: 177, height: 42, alignment: .center)
                    .foregroundColor(.black)
            }
            Picker("m/s", selection: $spinnerOpt) {
                ForEach(units, id: \.self) { unit in
                    Text(unit)
                        .tag(unit)
                        .font(.custom("GlacialIndifference-Regular", size: 28))
                        .accentColor(.black)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .font(.custom("GlacialIndifference-Regular", size: 28))
            .accentColor(.black)
            .frame(width: 100)
            .onChange(of: spinnerOpt) { _ in
                // Recalculate result whenever spinnerOpt changes
                calculateResult()
            }
        }
    }
    
    func calculateResult() {
        // Check if any input is missing
        showPlaceholder = [
            descarga == nil,
            ancho == nil,
            volumen == nil
        ]
        // Calculate if all inputs are given
        if showPlaceholder.contains(true) == false {
            // m/s result option
            var calculation = ((10000 / (ancho ?? 1.0)) / ((volumen ?? 0.0) / (descarga ?? 1.0))) / 60
            // km/h result option
            if spinnerOpt == "km/h" {
                calculation = calculation * 3.6
            }
            resultado = calculation
        } else {
            resultado = nil // Clear previous result if validation fails
        }
    }
    
    @ViewBuilder
    func navigationMenu() -> some View {
        // Navigation menu
        HStack {
            // Herbicidas navigation
            NavigationLink(destination: herbicidas(goToMenuFromHerb: $goToHerbicidasMenu), isActive: $goToHerbicidas) {
                Image("icon_herb")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 58.6, height: 58.6)
            }
            // Icon spacer / divider
            Image("icon_divider")
                .resizable(resizingMode: .stretch)
                .frame(width: 40, height: 49.4)
            // Fungicidas icon navigation
            NavigationLink(destination: fungicidas(goToMenuFromHerb: $goToHerbicidasMenu), isActive: $goToFungicidas) {
                Image("icon_fung2")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 58.6, height: 58.6)
            }
            // Icon spacer / divider
            Image("icon_divider")
                .resizable(resizingMode: .stretch)
                .frame(width: 40, height: 49.4)
            // Dosificacion icon navigation
            NavigationLink(destination: dosificacion(goToHerbicidasMenu: $goToHerbicidasMenu), isActive: $goToDosificacion) {
                Image("icon_dosi")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 58.6, height: 58.6)
            }
        } // HStack
    } // NavigationMenu
} // Herbicidas View

#Preview {
    //herbicidas_vol_fijo()
}
