//
//  ContentView.swift
//  Unit Converter
//
//  Created by Anastasia Kotova on 21.02.23.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput = 0.0
    
    @State var selectionOfTypeOfConversion: Conversions = .temperature
    @State var selectionFromConversion: String = TemperatureConversions.celsius.rawValue
    @State var selectionToConversion: String = TemperatureConversions.celsius.rawValue
    @FocusState private var inputIsFocused: Bool
    let backgroundColor: Color = Color(red: 115/255, green: 82/255, blue: 64/255)
    let textColor: Color = Color(red: 255/255, green: 241/255, blue: 230/255)
    
    var output: Double {
        switch selectionFromConversion {
        case TemperatureConversions.celsius.rawValue:
            return fromCelsius()
        case TemperatureConversions.fahrenheit.rawValue:
            return fromFahrenheit()
        case TemperatureConversions.kelvin.rawValue:
            return fromKelvin()
        case LengthConversions.meters.rawValue:
            return fromMeters()
        case LengthConversions.feet.rawValue:
            return fromFeet()
        case LengthConversions.miles.rawValue:
            return fromMiles()
        case VolumeConversions.milliliters.rawValue:
            return fromMilliliters()
        case VolumeConversions.pints.rawValue:
            return fromPints()
        case VolumeConversions.gallons.rawValue:
            return fromGallons()
        default:
            return userInput
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section {
                        Picker("Type of conversion", selection: $selectionOfTypeOfConversion) {
                            ForEach(Conversions.allCases, id: \.self) {
                                Text($0.rawValue)
                                
                            }
                        }.onChange(of: selectionOfTypeOfConversion) { _ in
                            checkConvention()
                        }
                        TextField("", value: $userInput, format: .number)
                            .keyboardType(.numbersAndPunctuation)
                            .focused($inputIsFocused)
                        Picker("From conversion", selection: $selectionFromConversion) {
                            switch selectionOfTypeOfConversion {
                            case Conversions.temperature:
                                ForEach(TemperatureConversions.allCases, id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            case Conversions.length:
                                ForEach(LengthConversions.allCases, id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            case Conversions.volume:
                                ForEach(VolumeConversions.allCases, id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            }
                        }
                    } header: {
                        Text("From")
                            .foregroundColor(textColor)
                            .bold()
                            .font(.title)
                    }
                    
                    Section {
                        Picker("To conversion", selection: $selectionToConversion) {
                            switch selectionOfTypeOfConversion {
                            case Conversions.temperature:
                                ForEach(TemperatureConversions.allCases, id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            case Conversions.length:
                                ForEach(LengthConversions.allCases, id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            case Conversions.volume:
                                ForEach(VolumeConversions.allCases, id: \.self) {
                                    Text($0.rawValue).tag($0.rawValue)
                                }
                            }
                        }
                        Text(output, format: .number)
                    } header: {
                        Text("To")
                            .foregroundColor(textColor)
                            .bold()
                            .font(.title)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(backgroundColor)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            inputIsFocused = false
                        }
                    }
                }
            }
        }
    }
    
    private func checkConvention() {
        if selectionOfTypeOfConversion == Conversions.temperature {
            selectionFromConversion = TemperatureConversions.celsius.rawValue
            selectionToConversion = TemperatureConversions.celsius.rawValue
        } else if selectionOfTypeOfConversion == Conversions.length{
            selectionFromConversion =  LengthConversions.meters.rawValue
            selectionToConversion = LengthConversions.meters.rawValue
        } else if selectionOfTypeOfConversion == Conversions.volume{
            selectionFromConversion =  VolumeConversions.milliliters.rawValue
            selectionToConversion = VolumeConversions.milliliters.rawValue
        }
    }
    
    private func fromCelsius() -> Double {
        switch selectionToConversion {
        case TemperatureConversions.fahrenheit.rawValue:
            return (userInput * 9/5) + 32
        case TemperatureConversions.kelvin.rawValue:
            return userInput + 273.15
        default:
            return userInput
        }
    }
    
    private func fromFahrenheit() -> Double {
        switch selectionToConversion {
        case TemperatureConversions.celsius.rawValue:
            return (userInput - 32) * 5/9
        case TemperatureConversions.kelvin.rawValue:
            return (userInput - 32) * 5/9 + 273.15
        default:
            return userInput
        }
    }
    
    private func fromKelvin() -> Double {
        switch selectionToConversion {
        case TemperatureConversions.celsius.rawValue:
            return userInput - 273.15
        case TemperatureConversions.fahrenheit.rawValue:
            return (userInput - 273.15) * 9/5 + 32
        default:
            return userInput
        }
    }
    
    private func fromMeters() -> Double {
        switch selectionToConversion {
        case LengthConversions.feet.rawValue:
            return userInput * 3.281
        case LengthConversions.miles.rawValue:
            return userInput / 1609
        default:
            return userInput
        }
    }
    
    private func fromFeet() -> Double {
        switch selectionToConversion {
        case LengthConversions.meters.rawValue:
            return userInput / 3.281
        case LengthConversions.miles.rawValue:
            return userInput / 5280
        default:
            return userInput
        }
    }
    
    private func fromMiles() -> Double {
        switch selectionToConversion {
        case LengthConversions.meters.rawValue:
            return userInput * 1609
        case LengthConversions.feet.rawValue:
            return userInput * 5280
        default:
            return userInput
        }
    }
    
    private func fromMilliliters() -> Double {
        switch selectionToConversion {
        case VolumeConversions.pints.rawValue:
            return userInput / 473.2
        case VolumeConversions.gallons.rawValue:
            return userInput / 3785
        default:
            return userInput
        }
    }
    
    private func fromPints() -> Double {
        switch selectionToConversion {
        case VolumeConversions.milliliters.rawValue:
            return userInput * 473.2
        case VolumeConversions.gallons.rawValue:
            return userInput / 8
        default:
            return userInput
        }
    }
    
    private func fromGallons() -> Double {
        switch selectionToConversion {
        case VolumeConversions.milliliters.rawValue:
            return userInput * 3785
        case VolumeConversions.pints.rawValue:
            return userInput * 8
        default:
            return userInput
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Conversions: String, CaseIterable {
    case temperature = "temperature"
    case length = "length"
    case volume = "volume"
}

enum TemperatureConversions: String, CaseIterable {
    var id: Self { self }
    
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    case kelvin = "kelvin"
}

enum LengthConversions: String, CaseIterable {
    var id: Self { self }
    
    case meters = "meters"
    case feet = "feet"
    case miles = "miles"
}

enum VolumeConversions: String, CaseIterable {
    var id: Self { self }
    
    case milliliters = "ml"
    case pints = "pints"
    case gallons = "gallons"
}
