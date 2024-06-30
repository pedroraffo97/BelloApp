//
//  Recommendation.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 25.11.23.
//

import Foundation

import SwiftUI




struct Recommendation {
 var name: String = ""
 var factors: String = ""
 var description: String = ""
}

let underweight = Recommendation(
    name: "Underweight",
    factors: "BMI less than 18.5",
    description: """
    - Focus on strength training to build lean muscle mass.
    - Include cardiovascular exercises for overall health.
    - Ensure a balanced diet with sufficient calories and nutrients.
    """)

let normalweight = Recommendation(
    name: "Normal weight",
    factors: "BMI 18.5 to 24.9",
    description: """
    - Maintain a balanced exercise routine that includes both cardio and strength training.
    - Consider incorporating high-intensity interval training (HIIT) for variety and efficiency.
    - Continue to focus on a well-rounded, nutritious diet.
    """
    )

let overweight = Recommendation(
    name: "Overweight",
    factors: "BMI 25 to 29.9",
    description: """
    - Combine aerobic exercises (such as running, cycling, or swimming) with strength training.
    - Prioritize activities that burn calories and improve cardiovascular health.
    - Pay attention to dietary habits, focusing on a calorie deficit for weight loss.
    """
    )
let obesity = Recommendation(
    name: "Obesity" ,
    factors: "BMI 30 or higher",
    description: """
    - Begin with low-impact exercises like walking or swimming to reduce strain on joints.
    - Gradually increase intensity and duration of cardiovascular exercises.
    - Incorporate strength training to build muscle mass and boost metabolism.
    - Emphasize a well-balanced, calorie-controlled diet.
    """
    )
