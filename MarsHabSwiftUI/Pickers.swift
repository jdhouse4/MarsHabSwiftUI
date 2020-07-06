//
//  Pickers.swift
//  AppleWorld
//
//  Created by James Hillhouse IV on 5/12/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI
import CoreML




struct Pickers: View {
    // MARK: -Properties

    /// Bindings
    @Binding var price: String
    @Binding var selectedSolarPanelIndex: Int
    @Binding var selectedGreenhousesIndex: Int
    @Binding var selectedSizeIndex: Int



    var totalPrice: Double {
        Double(updatePredictedPrice(solarPanelIndex: self.selectedSolarPanelIndex, greenhousesIndex: self.selectedGreenhousesIndex, sizeIndex: self.selectedSizeIndex))!
    }


    /// Data Sources
    private let solarPanelDataSource    = SolarPanelDataSource()
    private let greenhousesDataSource   = GreenhousesDataSource()
    private let sizeDataSource          = SizeDataSource()


    /// The regression data model
    let model = try? MarsHabitatPricer(configuration: MLModelConfiguration())

    let pickerNameHeight: CGFloat       = 50
    let pickerFrameHeight: CGFloat      = 180
    let priceMinFrameHeight: CGFloat    = 100
    let priceMaxFrameHeight: CGFloat    = 500

    let priceBackgroundColor            = 0.375

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                VStack(spacing: 0) {

                    /// Picker labels
                    HStack {
                        Text("Solar Panels")
                            .frame(width: geometry.size.width/3, height: self.pickerNameHeight, alignment: .center)

                        Text("Greenhouses")
                            .frame(width: geometry.size.width/3, height: self.pickerNameHeight, alignment: .center)

                        Text("Acres")
                            .frame(width: geometry.size.width/3, height: self.pickerNameHeight, alignment: .center)
                    }
                    .frame(height: self.pickerNameHeight, alignment: .center)
                    .background(Color.init(red: 0.9, green: 0.9, blue: 0.9))


                    /// Pickers
                    HStack {
                        /// Picker for Solar Panel
                        Picker(selection: self.$selectedSolarPanelIndex, label: Text("")) {
                            ForEach(0 ..< self.solarPanelDataSource.values.count) {
                                Text(self.solarPanelDataSource.title(for: $0)!)//.tag($0)
                            }
                        }
                        .frame(width: geometry.size.width/3, height: self.pickerFrameHeight, alignment: .center)
                        //.background(Color.yellow)


                        /// Picer for Greenhouses
                        Picker(selection: self.$selectedGreenhousesIndex, label: Text("")) {
                            ForEach(0 ..< self.greenhousesDataSource.values.count) { index in
                                Text(self.greenhousesDataSource.title(for: index)!)//.tag(index)
                            }
                        }
                        .frame(width: geometry.size.width/3, height: self.pickerFrameHeight, alignment: .center)
                        //.background(Color.red)


                        /// Picker for Size
                        Picker(selection: self.$selectedSizeIndex, label: Text("")) {
                            ForEach(0 ..< self.sizeDataSource.values.count) {
                                Text(self.sizeDataSource.title(for: $0)!)//.tag($0)
                            }
                        }
                        .frame(width: geometry.size.width/3, height:self.pickerFrameHeight, alignment: .center)
                        //.background(Color.green)
                    }
                    .background(Color.white)
                    


                    /// Price
                    HStack {
                        VStack(spacing: 0) {
                            //Text("Price: $\(self.updatePredictedPrice(solarPanelIndex: self.selectedSolarPanelIndex, greenhousesIndex: self.selectedGreenhousesIndex, sizeIndex: self.selectedSizeIndex))")

                            Text("Predicted Price (millions)")
                                .font(.title)
                                .foregroundColor(.white)

                                .padding()

                            Text("$\(self.totalPrice, specifier: "%.0f")")
                                .font(.largeTitle)
                                .foregroundColor(Color.white)

                            Spacer(minLength: 10)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: self.priceMinFrameHeight, maxHeight: self.priceMaxFrameHeight, alignment: .center)
                    //.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(Color.init(red: self.priceBackgroundColor, green: self.priceBackgroundColor, blue: self.priceBackgroundColor))
                }
            }


            /*
            VStack(alignment: .leading) {
                Text("selectedSolarPanelIndex: \(self.selectedSolarPanelIndex)")
                Text("selectedGreenhousesIndex: \(self.selectedGreenhousesIndex)")
                Text("selectedSizeIndex: \(self.selectedSizeIndex)")
            }
            */

                //.padding(-50)
            //Spacer(minLength: -50)

        }
    }



    func updatePredictedPrice(solarPanelIndex: Int, greenhousesIndex: Int, sizeIndex: Int) -> String {

        let solarPanels: Double = solarPanelDataSource.value(for: solarPanelIndex)!
        let greenhouses: Double = greenhousesDataSource.value(for: greenhousesIndex)!
        let size: Double = sizeDataSource.value(for: sizeIndex)!

        guard let marsHabitatPricerOutput = try? model!.prediction(solarPanels: solarPanels, greenhouses: greenhouses, size: size) else {
            fatalError("Unexpected runtime error.")
        }

        let price = marsHabitatPricerOutput.price
        //priceLabel.text = priceFormatter.string(for: price)

        return String(price)
        //return self.$price = String(price)
    }

}





struct Pickers_Previews: PreviewProvider {
    static var previews: some View {
        Pickers(price: .constant("1"), selectedSolarPanelIndex: .constant(2), selectedGreenhousesIndex: .constant(2), selectedSizeIndex: .constant(4))
    }
}
