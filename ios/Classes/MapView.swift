//
//  MapView.swift
//  tplmapsflutterplugin
//
//  Created by Zaeem EhsanUllah on 22/02/2022.
//

import UIKit
import TPLMaps
@IBDesignable class MapView: TPLMaps.TPLMapView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }

    private func commonInit() {
        self.clipsToBounds = true
    }
}
