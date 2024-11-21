//
//  herbicidas_vol_apl.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct herbicidas_vol_apl: View {
    let screenWidth = UIScreen.main.bounds.size.width;
    
    // Navigation variables
    @Binding var goToHerbicidasMenu: Bool
    @State private var goToHerbicidas = false
    @State private var goToFungicidas = false
    @State private var goToDosificacion = false
    
    // Input variables
    @State private var area: Double? = nil
    @State private var volI: Double? = nil
    @State private var volF: Double? = nil
    @State private var resultado: Double? = nil
    
    // State variables to control placeholder display - See if input is already introduced
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
                    .frame(width: 580, height: 230)
                VStack {
                    // Screen Title
                    Spacer(minLength: 30)
                    Text("Método del volumen\naplicado en un área\nconocida")
                        .font(.custom("GlacialIndifference-Regular", size: 31.2))
                        .foregroundColor(.black)
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                    // Method description
                    Spacer(minLength: 6)
                    Text("Determina el volumen de aplicación por hectárea. Marque un área conocida y aplique allí agua a la velocidad usual.")
                        .font(.custom("GlacialIndifference-Regular", size: 20.8))
                        .foregroundColor(Color(hex: "#373636"))
                        .frame(width: 377, height: 120, alignment: .center)
                }
            }
            Spacer(minLength: 32)
            
            // First input
            inputField("Área aplicada (m", exponent: "2", value: createBinding(for: $area, placeholderIndex: 0), placeholderIndex: 0, hint: "Área")
            Spacer(minLength: 15)
            // Second input
            inputField("Volumen inicial (litros", value: createBinding(for: $volI, placeholderIndex: 1), placeholderIndex: 1, hint: "Volumen")
            Spacer(minLength: 15)
            // Third input
            inputField("Volumen final (litros", value: createBinding(for: $volF, placeholderIndex: 2), placeholderIndex: 2, hint: "Volumen")
            
            // Calculate button
            Spacer(minLength: 25)
            HStack {
                Spacer() // Pushes the text to the right
                Button(action: {
                    // Check if any input is missing
                    showPlaceholder = [
                        area == nil,
                        volI == nil,
                        volF == nil
                    ]
                    // Calculate if all inputs are given
                    if showPlaceholder.contains(true) == false {
                        let calculation = (((volI ?? 0.0) - (volF ?? 0.0)) * 10000) / (area ?? 1.0)
                        resultado = calculation
                    } else {
                        resultado = nil // Clear previous result if validation fails
                    }
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
            Spacer(minLength: 20)
            
            // Show result
            result(resultado: resultado)
            Spacer(minLength: 30)
            
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
            + Text(exponent)
                .baselineOffset(6.0)
                .font(.custom("GlacialIndifference-Regular", size: 12))
                .foregroundColor(Color(hex: "#373636"))
            + Text("):")
                .font(.custom("GlacialIndifference-Regular", size: 20.6))
                .foregroundColor(Color(hex: "#373636"))
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
            Text("litros/ha")
                .font(.custom("GlacialIndifference-Regular", size: 28))
                .frame(width: 110, height: 32.5, alignment: .center)
                .foregroundColor(.black)
                .fontWeight(.bold)
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
    //herbicidas_vol_apl()
}
