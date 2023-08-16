//
//  Gradients.swift
//  Eventiva
//
//  Created by Shakthi Sachintha on 2023-08-15.
//

import Foundation
import SwiftUI

let leftToRightGradients: [LinearGradient] = [
    
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.78, green: 0.91, blue: 0.96).opacity(0.35), location: 0.00),
            Gradient.Stop(color: Color(red: 0.71, green: 0.84, blue: 0.87).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.94, green: 0.71, blue: 0.39).opacity(0.28), location: 0.00),
            Gradient.Stop(color: Color(red: 0.76, green: 0.49, blue: 0.37).opacity(0), location: 0.92),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.19, green: 0.64, blue: 0.84).opacity(0.33), location: 0.00),
            Gradient.Stop(color: Color(red: 0.61, green: 0.58, blue: 0.58).opacity(0), location: 0.97),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 1)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.96, green: 0.88, blue: 0.76).opacity(0.26), location: 0.00),
            Gradient.Stop(color: Color(red: 0.41, green: 0.3, blue: 0.3).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 0.98, y: 1.04)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.46, green: 0.52, blue: 0.66).opacity(0.32), location: 0.00),
            Gradient.Stop(color: Color(red: 0.24, green: 0.33, blue: 0.49).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    ),
    
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.58, green: 0.42, blue: 0.69).opacity(0.28), location: 0.00),
            Gradient.Stop(color: Color(red: 0.44, green: 0.26, blue: 0.47).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.53, green: 0.64, blue: 0.86).opacity(0.30), location: 0.00),
            Gradient.Stop(color: Color(red: 0.29, green: 0.42, blue: 0.66).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    ),
    
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.72, green: 0.22, blue: 0.49).opacity(0.28), location: 0.00),
            Gradient.Stop(color: Color(red: 0.58, green: 0.15, blue: 0.38).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    ),]

let rightToLeftGradients: [LinearGradient] = [
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.8, green: 0.32, blue: 0.61).opacity(0.24), location: 0.00),
            Gradient.Stop(color: Color(red: 0.87, green: 0.7, blue: 0.7).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.46),
        endPoint: UnitPoint(x: 0, y: 1)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.34, green: 0.75, blue: 0.46).opacity(0.33), location: 0.00),
            Gradient.Stop(color: Color(red: 0.32, green: 0.67, blue: 0.44).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.64),
        endPoint: UnitPoint(x: 0.5, y: 1)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.84, green: 0.42, blue: 0.71).opacity(0.25), location: 0.00),
            Gradient.Stop(color: Color(red: 0.63, green: 0.25, blue: 0.41).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.5),
        endPoint: UnitPoint(x: 0, y: 0.5)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.57, green: 0.62, blue: 0.92).opacity(0.32), location: 0.00),
            Gradient.Stop(color: Color(red: 0.38, green: 0.43, blue: 0.71).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.5),
        endPoint: UnitPoint(x: 0, y: 0.5)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.89, green: 0.64, blue: 0.32).opacity(0.34), location: 0.00),
            Gradient.Stop(color: Color(red: 0.76, green: 0.46, blue: 0.14).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.5),
        endPoint: UnitPoint(x: 0, y: 0.5)
    ),
    
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.26, green: 0.42, blue: 0.54).opacity(0.31), location: 0.00),
            Gradient.Stop(color: Color(red: 0.11, green: 0.29, blue: 0.39).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.5),
        endPoint: UnitPoint(x: 0, y: 0.5)
    ),
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.45, green: 0.56, blue: 0.69).opacity(0.32), location: 0.00),
            Gradient.Stop(color: Color(red: 0.22, green: 0.33, blue: 0.46).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.5),
        endPoint: UnitPoint(x: 0, y: 0.5)
    ),
    
    LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.79, green: 0.45, blue: 0.18).opacity(0.28), location: 0.00),
            Gradient.Stop(color: Color(red: 0.65, green: 0.29, blue: 0.12).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1, y: 0.5),
        endPoint: UnitPoint(x: 0, y: 0.5)
    ),
]


func getGradient(_ index: Int) -> LinearGradient {
    let randomLeftToRightIndex = Int.random(in: 0..<leftToRightGradients.count)
    let randomRightToLeftIndex = Int.random(in: 0..<rightToLeftGradients.count)
    
    if index.isMultiple(of: 2) {
        return leftToRightGradients[randomLeftToRightIndex]
    } else {
        return rightToLeftGradients[randomRightToLeftIndex]
    }
}

