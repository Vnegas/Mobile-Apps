//
//  ContentView.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct menu: View {
    @State private var goToMenu = false
    let screenWidth = UIScreen.main.bounds.size.width;
    var body: some View {
        NavigationView {
            ZStack {
                Image("menu_bg")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: /*@START_MENU_TOKEN@*/500.0/*@END_MENU_TOKEN@*/, height: 980.0)
                    
                LazyVStack {
                    // Title
                    Text("Calibración")
                        .foregroundColor(.white)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 57.2))
                        .fontWeight(.bold)
                        .padding()
                    Spacer(minLength: 50)
                    // Button to Herbicidas
                    NavigationLink(destination: herbicidas(goToMenu: $goToMenu), isActive: $goToMenu) {
                        // Herbicidas icon
                        Image("icon_herb")
                            .resizable(resizingMode: .stretch)
                            .offset(x: 20)
                            .frame(width: 50.4, height: 43.9)
                        
                        Text("HERBICIDAS")
                            .font(.custom("GlacialIndifference-Regular", size: 31.2))
                            .padding(.trailing, 18.0)
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    Spacer(minLength: 30)
                    // Button to Fungicidas
                    NavigationLink(destination: fungicidas(goToMenu: $goToMenu), isActive: $goToMenu) {
                        // Herbicidas icon
                        Image("icon_fung2")
                            .resizable(resizingMode: .stretch)
                            .offset(x: 20)
                            .frame(width: 44.4, height: 40.9)
                        
                        Text("FUNGICIDAS E INSECTICIDAS")
                            .font(.custom("GlacialIndifference-Regular", size: 31.2))
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    Spacer(minLength: 30)
                    // Button to Dosificacion
                    NavigationLink(destination: herbicidas(goToMenu: $goToMenu), isActive: $goToMenu) {
                        // Herbicidas icon
                        Image("icon_dosi")
                            .resizable(resizingMode: .stretch)
                            .offset(x: 20)
                            .frame(width: 44.4, height: 40.9)
                        
                        Text("DOSIFICACIÓN")
                            .font(.custom("GlacialIndifference-Regular", size: 31.2))
                            .frame(width: 240, height: 104, alignment: .center)
                            .foregroundColor(.accent)
                            .cornerRadius(80)
                    }.background {
                        RoundedRectangle(cornerRadius: 80)
                            .fill(.white)
                            .stroke(.accent, lineWidth: 4)
                    }
                    Spacer(minLength: 70)
                    HStack {
                        // Button to go back
                        NavigationLink(destination: menu()) {
                            Text("ATRÁS")
                                .font(.custom("GlacialIndifference-Regular", size: 28.6))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer(minLength: 5)
                        // Button to go to Youtube video for help
                        NavigationLink(destination: menu()) {
                            Text("AYUDA")
                                .font(.custom("GlacialIndifference-Regular", size: 28.6))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.trailing)
                                
                        }
                    }.frame(width: screenWidth - 80, height: 34)
                    Spacer()
                }
                // Default back button disabled
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    menu()
}

// FUENTES
// Cambria
// GlacialIndifference-Regular
// NotoSerifDisplay-ExtraCondensed
// NotoSerifDisplay-ExtraCondensedItalic

/*
 init() {
     for familyName in UIFont.familyNames {
         print(familyName)
         for fontName in UIFont.fontNames(forFamilyName:
                                             familyName) {
             print("-- \(fontName)")
         }
     }
 }
 */

// ATRAS BOTON
/*
 @Environment(\.presentationMode) private var
     presentationMode: Binding<PresentationMode>
 
 
 Spacer()
     .navigationBarBackButtonHidden(true)
     .toolbar(content: {
         ToolbarItem(placement:
                 .navigationBarLeading) {
                     Button(action: {
                         presentationMode.wrappedValue.dismiss()
                     }, label: {
                         Text("Atrás").foregroundColor(.black)
                     })
                            
                }
    })
 */
