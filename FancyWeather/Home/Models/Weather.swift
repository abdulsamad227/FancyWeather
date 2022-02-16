//
//  Weather.swift
//  FancyWeather
//
//  Created by Abdulsamad on 14/02/2022.
//

import Foundation

struct Weather: Codable {
    let coord: Coord
    let weather: [WeatherAPI]
    let main: Main
    let wind: Wind
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherAPI: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Float
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
