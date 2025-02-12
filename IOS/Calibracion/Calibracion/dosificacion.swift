//
//  dosificacion.swift
//  Calibracion
//
//  Created by vnegas on 17/11/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct dosificacion: View {
    let screenWidth = UIScreen.main.bounds.size.width;
    
    // Navigation variables
    @Binding var goToHerbicidasMenu: Bool
    @State private var goToHerbicidas = false
    @State private var goToFungicidas = false
    @State private var goToDosificacion = false
    
    // Input variables
    @State private var volumen: Double? = nil
    @State private var dosis: Double? = nil
    @State private var area: Double? = nil
    // Result variables
    @State private var resultado1: Double? = nil
    @State private var resultado2: Double? = nil
    @State private var resultado3: Double? = nil
    
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
                Spacer(minLength: geometry.size.height * 0.06)
                HStack {
                    // Herbicidas icon
                    Image("icon_dosi")
                        .resizable()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.09)
                    // Screen Title
                    Text("Dosificación")
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: geometry.size.width * 0.09))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
                Spacer(minLength: geometry.size.height * 0.025)
                
                // First input
                inputField("Volumen de aplicación (l/ha", value: createBinding(for: $volumen, placeholderIndex: 0), placeholderIndex: 0, hint: "Volumen", geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.015)
                // Second input
                inputField("Dosis de PC por ha (litros", value: createBinding(for: $dosis, placeholderIndex: 1), placeholderIndex: 1, hint: "Dosis", geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.02)
                
                // Show result1
                result("Resultado: PC (ml) por litro de agua", resultado: resultado1, geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.03)
                
                // Third input
                inputField("Área por aplicar (m", exponent: "2", value: createBinding(for: $area, placeholderIndex: 2), placeholderIndex: 2, hint: "Área", geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.02)
                
                // Show result2
                result("Resultado: Agua necesaria (litros)", resultado: resultado2, geometry: geometry)
                Spacer(minLength: geometry.size.height * 0.015)
                // Show result3
                result("Resultado: PC (ml) por área", resultado: resultado3, geometry: geometry)
                
                // Calculate button
                Spacer(minLength: geometry.size.height * 0.05)
                HStack {
                    // Instructions / Glossary
                    Text("PC = Producto Comercial\nl/ha = litros por hectárea")
                        .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.049))
                        .frame(alignment: .center)
                        .foregroundColor(.black)
                    Spacer() // Pushes the button to the right
                    Button(action: {
                        // Check if any input is missing
                        showPlaceholder = [
                            volumen == nil,
                            dosis == nil,
                            area == nil
                        ]
                        // Calculate if all inputs are given
                        if showPlaceholder.contains(true) == false {
                            let calculation1 = ((dosis ?? 0.0) / (volumen ?? 1.0)) * 1000
                            resultado1 = calculation1
                            
                            let calculation2 = ((volumen ?? 0.0) * (area ?? 0.0)) / 10000
                            resultado2 = calculation2
                            
                            let calculation3 = (((dosis ?? 0.0) * (area ?? 0.0)) / 10000) * 1000
                            resultado3 = calculation3
                        } else {
                            resultado1 = nil // Clear previous result if validation fails
                            resultado2 = nil // Clear previous result if validation fails
                            resultado3 = nil // Clear previous result if validation fails
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
                Spacer(minLength: geometry.size.height * 0.05)
                
                navigationMenu(width: geometry.size.width, height: geometry.size.height)
                Spacer(minLength: geometry.size.height * 0.01)
            } // LazyVStack
        }
        .background(Color(hex: "#F4F4F4"))
        .edgesIgnoringSafeArea(.all) // Fills all screen
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // Body
    
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
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.07)
                Text(resultado != nil ? "\(formatNumber(resultado!))" : "Resultado")
                    .font(.custom("GlacialIndifference-Regular", size: geometry.size.width * 0.05))
                    .frame(width: 123, height: 36.4, alignment: .center)
                    .foregroundColor(.black)
            }
        }
        .padding(.trailing, 16)
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
} // Dosificacion View

#Preview {
    dosificacion(goToHerbicidasMenu: .constant(false))
}
