//
//  dosificacion.swift
//  Calibracion
//
//  Created by vnegas on 17/11/24.
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
        LazyVStack {
            Spacer(minLength: 85)
            HStack {
                // Herbicidas icon
                Image("icon_dosi")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 59.8, height: 59.8)
                // Screen Title
                Text("Dosificación")
                    .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 46))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            
            Spacer(minLength: 36)
            
            // First input
            inputField("Volumen de aplicación (l/ha", value: createBinding(for: $volumen, placeholderIndex: 0), placeholderIndex: 0, hint: "Volumen")
            Spacer(minLength: 15)
            // Second input
            inputField("Dosis de PC por ha (litros", value: createBinding(for: $dosis, placeholderIndex: 1), placeholderIndex: 1, hint: "Dosis")
            Spacer(minLength: 20)
            
            // Show result1
            result("Resultado: PC (ml) por litro de agua", resultado: resultado1)
            Spacer(minLength: 30)
            
            // Third input
            inputField("Área por aplicar (m", exponent: "2", value: createBinding(for: $area, placeholderIndex: 2), placeholderIndex: 2, hint: "Área")
            Spacer(minLength: 20)
            
            // Show result2
            result("Resultado: Agua necesaria (litros)", resultado: resultado2)
            Spacer(minLength: 15)
            // Show result3
            result("Resultado: PC (ml) por área", resultado: resultado3)
            
            // Calculate button
            Spacer(minLength: 30)
            HStack {
                // Instructions / Glossary
                Text("PC = Producto Comercial\nl/ha = litros por hectárea")
                    .font(.custom("GlacialIndifference-Regular", size: 18.2))
                    .frame(width: 235, height: 58, alignment: .center)
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
                        .font(.custom("GlacialIndifference-Regular", size: 18.2))
                        .frame(width: 128, height: 57.2, alignment: .center)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(20)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing) // Aligns HStack to the right side of the screen
            .padding()
            Spacer(minLength: 35)
            
            navigationMenu()
            Spacer(minLength: 20)
            
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
                .font(.custom("GlacialIndifference-Regular", size: 18.2))
                .foregroundColor(Color(hex: "#373636"))
            + Text(exponent)
                .baselineOffset(6.0)
                .font(.custom("GlacialIndifference-Regular", size: 10))
                .foregroundColor(Color(hex: "#373636"))
            + Text("):")
                .font(.custom("GlacialIndifference-Regular", size: 18.2))
                .foregroundColor(Color(hex: "#373636"))
            Spacer()
            TextField(showPlaceholder[placeholderIndex] ? "Agregar Dato" : "\(hint)", text: value)
                .keyboardType(.numberPad)
                .font(.custom("GlacialIndifference-Regular", size: 18.2))
                .foregroundColor(showPlaceholder[placeholderIndex] ? Color(hex: "#68FF0000") : Color(hex: "#373636"))
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 46, alignment: .center)
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
    func result(_ label: String, resultado: Double?) -> some View {
        HStack {
            Text(label)
                .font(.custom("GlacialIndifference-Regular", size: 18.2))
                .frame(width: 195, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .fontWeight(.bold)
            ZStack {
                Image("result_shape")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 169, height: 52)
                Text(resultado != nil ? "\(formatNumber(resultado!))" : "Resultado")
                    .font(.custom("GlacialIndifference-Regular", size: 18.2))
                    .frame(width: 123, height: 36.4, alignment: .center)
                    .foregroundColor(.black)
            }
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
} // Dosificacion View

// Allows color in hex code: "#373636"


#Preview {
    //dosificacion()
}
