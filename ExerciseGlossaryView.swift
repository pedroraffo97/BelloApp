//
//  ExerciseGlossaryView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 04.11.23.
//

import Foundation

import SwiftUI

struct ExerciseGlossaryView: View {
    @EnvironmentObject var exerciseglossary: ExerciseGlossary
    @EnvironmentObject var data: Routine
    @State private var searchText: String = ""
    @State var selectRoutine: String = ""
    @State private var selectedExercise: Exercise? = nil
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exerciseglossary.ExerciseGuide
        }
        else {
            return exerciseglossary.ExerciseGuide.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                exercise.bodypart.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                exercise.display.localizedCaseInsensitiveContains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        VStack{
            NavigationView{
                ScrollView(.vertical){
                    let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(filteredExercises, id: \.self){exercise in
                            Button {
                                selectedExercise = exercise
                            } label: {
                                GeometryReader {
                                    geometry in
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black.opacity(0.8))
                                        .shadow(radius: 1.5)
                                        .frame(width: geometry.size.width - 10, height: 180)
                                        .overlay(
                                            VStack {
                                                Image(exercise.display)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                                VStack{
                                                    Text(exercise.name)
                                                    Text(exercise.bodypart)
                                                        .font(.footnote)
                                                    }
                                                .foregroundStyle(Color.white)
                                                }
                                                .padding()
                                            )
                                        }
                                    }
                                    .frame(height: 180)
                            }
                        }
                        .padding(15)
                    }
                    .navigationTitle("Exercise Glossary")
                    .searchable(text: $searchText)
                    .onAppear {
                        let searchTextField = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
                            searchTextField.textColor = .white  // Ensures entered text is white
                            searchTextField.attributedPlaceholder = NSAttributedString(
                                string: "Search",
                                attributes: [.foregroundColor: UIColor.lightGray] // Makes placeholder more visible
                            )
                        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
                    }
                    .background(Color.black.opacity(0.9))
                    .sheet(item: $selectedExercise){
                        exerciseType in
                        ExerciseView(exercise: exerciseType, data: data)
                    }
                }
            }
        }
    }


struct ExerciseGlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockExerciseGlossary = ExerciseGlossary()
        mockExerciseGlossary.ExerciseGuide = [
            Exercise(
                name: "Jumping Jacks",
                bodypart: "Full Body",
                information: """
            Jumping jacks are a full-body exercise that engages various muscle groups, including the legs, arms, and cardiovascular system.
            Variations:
            1- Modify the intensity by adjusting the pace—try faster or slower jumping jacks.
            2- Include a squat at the bottom of the movement to target the lower body more intensely.
            3- Add a clap overhead to increase the engagement of the shoulder muscles.
            """,
                execution: "To perform jumping jacks, start with feet together and arms at your sides. Jump your feet out while raising your arms overhead. Immediately reverse the motion by jumping back to the starting position. Repeat for the desired duration.",
                repetition: "60 seconds", // Adjust duration based on fitness level
                display: "jumping-jack",
                displayInstructions: "jumpingJacks_2",
                videolink: "shorts/_NOdJ88t_jA"
            ),

            Exercise(
                name: "Arm Circles",
                bodypart: "Shoulders and Arms",
                information: """
            Arm circles are a dynamic stretching exercise that targets the shoulder and arm muscles.
            Variations:
            1- Change the size of the circles to vary the intensity—small circles for a focused burn, larger circles for a broader range of motion.
            2- Perform circles forward and backward to engage different muscle fibers.
            3- Incorporate resistance by holding light weights in each hand.
            """,
                execution: "Stand with feet shoulder-width apart. Extend your arms straight out to the sides. Make small circular motions with your arms, gradually increasing the size of the circles. After a set time or number of repetitions, reverse the direction of the circles.",
                repetition: "45 seconds", // Adjust duration based on fitness level
                display: "armCircles",
                displayInstructions: "armCircles2",
                videolink: "shorts/lzR7tzI1JUI"
            )
        ]

        return ExerciseGlossaryView()
            .environmentObject(mockExerciseGlossary)
        }
    }
