//
//  Pickers.swift
//  AppleWorld
//
//  Created by James Hillhouse IV on 5/12/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct Pickers: View {
    // MARK: -Properties

    /// Bindings
    @Binding var price: Double

    var selectedSolarPanelIndex: Int   = 0
    var selectedGreenhousesIndex: Int  = 0


    /// Data Sources
    private let solarPanelDataSource    = SolarPanelDataSource()
    private let greenhousesDataSource   = GreenhousesDataSource()
    private let sizeDataSource          = SizeDataSource()



    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Picker(selection: self.$selectedFrameworkIndex, label: Text("")) {
                        ForEach(0 ..< self.appleFrameworksDataSource.frameworks.count) {
                            Text(self.appleFrameworksDataSource.title(for: $0)!).tag($0)
                        }
                    }
                    .frame(width: geometry.size.width/2, height: 25, alignment: .center)

                    Picker(selection: self.$selectedOSTypeIndex, label: Text("")) {
                        ForEach(0 ..< self.appleOSTypeDataSource.osTypes.count) { index in
                            Text(self.appleOSTypeDataSource.title(for: index)!).tag(index)
                        }
                    }
                    .frame(width: geometry.size.width/2, height: 25, alignment: .center)
                }
            }

            VStack(alignment: .leading) {
                Text("selectedFrameworkIndex: \(self.selectedFrameworkIndex)")
                Text("selectedOSTypeIndex: \(self.selectedOSTypeIndex)")
            }

            //.padding()
            Spacer(minLength: 100.0)
        }
    }
}




/*
struct Pickers_Previews: PreviewProvider {
    static var previews: some View {
        @State static var selectedFramework = "SwiftUI"

        Pickers(selectedFramework: $selectedFramework, selectedOSType: osTypes[0].rawValue)
    }
}

*/
