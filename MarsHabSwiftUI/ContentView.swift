//
//  ContentView.swift
//  MarsHabSwiftUI
//
//  Created by James Hillhouse IV on 5/12/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties

    @State private var price: Double = 0.0

    /// The regression data model
    let model = MarsHabitatPricer()

    /// Data source for the picker.
    let pickerDataSource = PickerDataSource()

    /// State variable we want to monitor
    //@State private var feature: Feature

    var body: some View {
        VStack {
            Text("The World of Apple")
                .font(.largeTitle)

            GeometryReader { geometry in
                HStack {
                    Picker(selection: self.$selectedFrameworkIndex, label: Text("")) {
                        ForEach(0 ..< self.frameworks.count) { index in
                            Text(self.frameworks[index]).tag(index)
                        }
                    }
                    .frame(width: geometry.size.width/2, height: 100, alignment: .center)

                    Picker(selection: self.$selectedOSTypeIndex, label: Text("")) {
                        ForEach(0 ..< self.osTypes.count) { index in
                            Text(self.osTypes[index]).tag(index)
                        }
                    }
                    .frame(width: geometry.size.width/2, height: 100, alignment: .center)
                }
                .padding()
            }

            Spacer()

            // This will be abstracted to an OutputView.swift
            Text("Your favorite framework: \(self.frameworks[self.selectedFrameworkIndex])")
            Text("Your favorite OS: \(self.osTypes[self.selectedOSTypeIndex])")
            Text("Your Apple World: \(self.frameworks[self.selectedFrameworkIndex]) on \(self.osTypes[self.selectedOSTypeIndex])")

            Spacer(minLength: 100)
            /*
             Picker(selection: $feature, label: Text("Mars Habitat Features")) {
             let selectedRow: Int = feature.rawValue
             let solarPanels = pickerDataSource.value(for: , feature: <#T##Feature#>)
             }
             */

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
