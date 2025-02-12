//
//  herbicidas_vol_apl.swift
//  Calibracion
//
//  Created by vnegas on 13/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
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
        GeometryReader { geometry in
            LazyVStack {
                Spacer(minLength: geometry.size.height * 0.005)
                ZStack {
                    Image("method_title_bg")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    VStack {
                        // Screen Title
                        Text("Método del volumen\naplicado en un área\nconocida")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.065))
                            .foregroundColor(.black)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        // Method description
                        Text("Determina el volumen de aplicación por hectárea. Marque un área conocida y aplique allí agua a la velocidad usual.")
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                            .foregroundColor(Color(hex: "#373636"))
                            .frame(width: geometry.size.width * 0.9, alignment: .center)
                    }
                }
                Spacer(minLength: geometry.size.height * 0.04)
                
                // First input
                inputField("Área aplicada (m", exponent: "2", value: createBinding(for: $area, placeholderIndex: 0), placeholderIndex: 0, hint: "Área", geometry: geometry)
                // Second input
                inputField("Volumen inicial (litros", value: createBinding(for: $volI, placeholderIndex: 1), placeholderIndex: 1, hint: "Volumen", geometry: geometry)
                // Third input
                inputField("Volumen final (litros", value: createBinding(for: $volF, placeholderIndex: 2), placeholderIndex: 2, hint: "Volumen", geometry: geometry)
                
                // Calculate button
                Spacer(minLength: geometry.size.height * 0.04)
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
                            .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.06, alignment: .center)
                            .foregroundColor(.black)
                            .background(Color.accentColor)
                            .cornerRadius(geometry.size.width * 0.05)
                    }
                }
                .padding(.horizontal, geometry.size.width * 0.05)
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Show result
                result(resultado: resultado, geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.04)
                
                navigationMenu(width: geometry.size.width, height: geometry.size.height)
            } // LazyVStack
            .edgesIgnoringSafeArea(.all) // Fills all screen
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(hex: "#F4F4F4"))
    } // Body
    
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
                .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.06, alignment: .trailing)
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
        // Navigation menu
        HStack {
            // Herbicidas navigation
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
                .frame(width: width * 0.1, height: height * 0.05)
            // Fungicidas icon navigation
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
                .frame(width: width * 0.1, height: height * 0.05)
            // Dosificacion icon navigation
            NavigationLink(destination: dosificacion(goToHerbicidasMenu: $goToHerbicidasMenu), isActive: $goToDosificacion) {
                Image("icon_dosi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.11)
            }
        } // HStack
        .navigationBarBackButtonHidden(true)
    } // NavigationMenu
} // Herbicidas View

#Preview {
    herbicidas_vol_apl(goToHerbicidasMenu: .constant(false))
}
