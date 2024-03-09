//
//  Settings.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 09.03.24.
//

import Foundation
import SwiftUI

class SettingsClass {
    var chartStyle: ChartStyle = .barChart
    var chartColor: Color = .blue
    
    static let shared = SettingsClass()
    
    private init() {}
    
}


