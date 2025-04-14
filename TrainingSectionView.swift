//
//  TrainingSectionView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 05.04.25.
//

import Foundation

import SwiftUI

import UIKit

import AudioToolbox

import AVFoundation

// MARK: - Vista para mostrar cada ejercicio individualmente
struct ExerciseDisplay: View {
    var exerciseName: String          // Nombre del ejercicio (ej. "Push Ups")
    var exercisePicture: String       // Nombre del archivo de imagen para el ejercicio
    var overrideRepetition: String? = nil

    var body: some View {
        VStack {
            // Imagen del ejercicio
            Image(exercisePicture)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()

            // Nombre del ejercicio
            Text(exerciseName)
                .foregroundStyle(.white)
                .font(.title)
                .bold()
                .padding(.top)

            // Repeticiones
            Text(overrideRepetition ?? "")
                .foregroundStyle(.white)
                .font(.headline)
                .padding(.bottom)
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Fondo gris claro
        .cornerRadius(16)                    // Bordes redondeados
    }
}


// MARK: - Vista que muestra la rutina de ejercicios paso a paso
struct WorkoutSessionView: View {
    var exercises: [Exercise]  // Lista de ejercicios
    var repetition: String? = nil
    var time: Float            // Tiempo total para completar la rutina
    var resttime: Float

    @Environment(\.dismiss) var dismiss   // Permite cerrar esta vista
    
    @State private var currentExerciseIndex = 0   // Índice del ejercicio actual
    @State private var lastExerciseIndex: Int = -1 // variable to track the last exercise index.
    
    @State private var timer: Timer? = nil        // Temporizador
    @State private var remainingTime: Float = 0   // Tiempo restante total
    @State private var isPaused = false           // Si el entrenamiento está pausado
    @State private var isResting = false          // Si esta en periodo de descanso
    
    @State private var progress: CGFloat = 0
    
    @State private var audioPlayer: AVAudioPlayer?
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
     
    var body: some View {
        GeometryReader {
            geometry in
            ZStack {
                if isResting {
                    Color.black.opacity(0.9)
                        .ignoresSafeArea()
                }
                else {
                    Color.black.opacity(0.9)
                        .ignoresSafeArea()
                    //Background that will fill with the progress
                    /*Color.gray.opacity(0.3)
                        .frame(height: geometry.size.height * progress)
                        .animation(.linear(duration: 1), value: progress)
                        .ignoresSafeArea()*/
                }
            // Contenido principal
            VStack(spacing: 20) {
                if isResting {
                    Text("Rest 🧘‍♂️")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    Text("Rest for \(Int(remainingTime))s")
                        .font(.headline)
                        .foregroundStyle(.gray)
                } else if exercises.indices.contains(currentExerciseIndex) {
                    ExerciseDisplay(exerciseName: exercises[currentExerciseIndex].name,  exercisePicture: exercises[currentExerciseIndex].display,
                                    overrideRepetition: repetition
                    )
                    //Show Circular progress
                    CircularProgressView(progress: progress)
                }
                
                // Mostrar el tiempo restante
                Text("Rest time: \(formatTime(Int(remainingTime)))")
                    .font(.title2)
                    .bold()
                    .foregroundColor(remainingTime <= 10 ? .red : .white) // Rojo si quedan ≤10s
                    .animation(.easeInOut, value: remainingTime)
                
            }
            
            .padding()
            .blur(radius: isPaused ? 3 : 0) // Desenfocar si está pausado
            
            // Capa visual que indica que está pausado
            if isPaused {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                Text("Training Paused")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            // Al tocar la vista se pausa o reanuda el entrenamiento
            isPaused.toggle()
        }
        .onLongPressGesture {
            dismiss() //dismiss the current exercise if pressing for long time.
        }
        .onAppear {
            startTimer() // Iniciar el temporizador cuando aparece la vista
        }
        .onDisappear {
            stopTimer() // Detener el temporizador cuando desaparece
            }
        }
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    /*func makeSound() {
        AudioServicesPlaySystemSound(1113)
    }*/
    
    func playAlertSound() {
        guard let url  = Bundle.main.url(forResource: "Little Bell Sound", withExtension: "wav") else {
            print("Sound file not found")
            return
        }
        do {
            //Allow sound to play without interrupting the music
            try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    

    // Inicia el temporizador que controla los cambios de ejercicio
    func startTimer() {
        remainingTime = time
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if !isPaused {
                remainingTime -= 1
                progress = CGFloat(1 - (remainingTime / time))

                if remainingTime <= resttime && !isResting {
                    isResting = true
                    vibrate()
                    playAlertSound()
                }
                
                if !isResting {
                    let activeTime = time - resttime
                    let timeElapsed = activeTime - (remainingTime - resttime)
                    progress = CGFloat(timeElapsed/activeTime)
                    
                    //Update currentExerciseIndex and vibrate if changed
                    let newIndex = min(Int((timeElapsed / activeTime) * Float(exercises.count)), exercises.count - 1)
                    if newIndex != currentExerciseIndex {
                        currentExerciseIndex = newIndex
                        vibrate()
                        playAlertSound()
                        lastExerciseIndex = newIndex
                    }
                }
                
                /*let activeTime = time - resttime
                /*let progress = 1 - (remainingTime - resttime) / activeTime
                currentExerciseIndex = min(Int(progress * Float(exercises.count)), exercises.count - 1)*/
                let indexProgress = 1 - (remainingTime - resttime) / activeTime
                currentExerciseIndex = min(Int(indexProgress * Float(exercises.count)), exercises.count - 1)*/
                
                if remainingTime <= 0 {
                    stopTimer()
                    playAlertSound()
                    vibrate()
                    withAnimation {
                        dismiss()
                    }
                }
            }
        }
    }

    // Detiene el temporizador
    func stopTimer() {
        timer?.invalidate()
        vibrate()
        playAlertSound()
        timer = nil
    }
}


// MARK: - Vista principal con botón para iniciar entrenamiento
struct TrainingSectionView: View {
    var buttonTitle: String
    var exercises: [Exercise]   // Arreglo de ejercicios que se van a mostrar
    var repetition: String? = nil
    var time: Float             // Tiempo total de la rutina (en segundos)
    var resttime: Float

    @State private var showSession = false  // Controla cuándo mostrar la vista de entrenamiento
    
    //MARK: Variables to change the color of the button after tapping
    @State private var tapCount = 0
    var tapstoChangeColor: Int

    var body: some View {
        VStack(spacing: 20) {
            // Botón que inicia el entrenamiento
            Button(action: {
                tapCount += 1
                withAnimation {
                    showSession = true
                }
            }) {
                /*Image(systemName: "play.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)*/
                Text(buttonTitle)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(tapCount >= tapstoChangeColor ? Color.green : Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            // Muestra WorkoutSessionView a pantalla completa
            .fullScreenCover(isPresented: $showSession) {
                WorkoutSessionView(exercises: exercises, repetition: repetition, time: time, resttime: resttime)
                    .transition(.move(edge: .bottom)) // Animación de entrada desde abajo
            }
        }
        //.padding()
    }
}

// MARK: - Vista previa para probar en Xcode
struct TrainingSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleExercises = [
            jumpingJacks,
            dumbbellPullover,
            armCircles
        ]

        TrainingSectionView(buttonTitle: "Estiremos", exercises: sampleExercises, time: 15, resttime: 5, tapstoChangeColor: 3)
    }
}
