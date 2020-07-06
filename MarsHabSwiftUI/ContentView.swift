//
//  ContentView.swift
//  MarsHabSwiftUI
//
//  Created by James Hillhouse IV on 5/12/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI
import CoreML

struct ContentView: View {
    // MARK: - Properties

    @State private var price: String = ""
    @State private var solarPanels: Int = 0
    @State private var greenhouses: Int = 0
    @State private var size: Int        = 0

    let orangeColor: Color = Color.init(red: 1.0, green: 0.6, blue: 0.0)

    let pickerMinFrameHeight: CGFloat   = 400
    let pickerMaxFrameHeight: CGFloat   = 1000

    /// The regression data model
    let model = try? MarsHabitatPricer(configuration: MLModelConfiguration())

    /// Data source for the picker.
    //let pickerDataSource = PickerDataSource()

    /// State variable we want to monitor
    //@State private var feature: Feature

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                orangeColor.edgesIgnoringSafeArea(.all)
                Text("Mars Habitat Pricer")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 60, alignment: .center)

            .background(orangeColor)

            Pickers(price: $price,
                    selectedSolarPanelIndex: $solarPanels,
                    selectedGreenhousesIndex: $greenhouses,
                    selectedSizeIndex: $size)
                .frame(minHeight: self.pickerMinFrameHeight, maxHeight: self.pickerMaxFrameHeight)

            /*
            // This will be abstracted to an OutputView.swift
            Text("Your favorite framework: \(self.frameworks[self.selectedFrameworkIndex])")
            Text("Your favorite OS: \(self.osTypes[self.selectedOSTypeIndex])")
            Text("Your Apple World: \(self.frameworks[self.selectedFrameworkIndex]) on \(self.osTypes[self.selectedOSTypeIndex])")
            */

            Spacer(minLength: 50)
        }
    //.background(Color.orange)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
