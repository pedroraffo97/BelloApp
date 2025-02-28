//
//  TimerView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 30.11.23.
//

import Foundation

import SwiftUI

class TimerManager: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    var timer: Timer?
    
}

struct TimerView: View {
    @State var selectedMinutes: Int = 0
    @State var selectedSeconds:Int = 0
    @State private var isTimerRunning: Bool = false
    @State var resumedTime: TimeInterval = 0
    @StateObject private var timerManager = TimerManager()
    // to track if the user is editing the time or not
    @State private var isEditing: Bool = false

    func Timeselection() -> Double {
        return Double(selectedMinutes * 60 ) + Double(selectedSeconds)
    }

    func startTimer() {
        isTimerRunning = true
        timerManager.elapsedTime = Timeselection()
        timerManager.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerManager.elapsedTime > 0 {
                timerManager.elapsedTime -= 1
            } else {
                self.stopTimer()
            }
        }
        
    }

    func stopTimer() {
        isTimerRunning = false
        timerManager.timer?.invalidate()
        timerManager.timer = nil
        resumedTime = timerManager.elapsedTime
    }
    
    func resumeTimer(){
        isTimerRunning = true
        timerManager.elapsedTime = resumedTime
        timerManager.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if timerManager.elapsedTime > 0 {
                timerManager.elapsedTime -= 1
            } else {
                self.stopTimer()
            }
            
        }
                             
    }
    //Design of the timer display converting the elapsed time in seconds in minutes and in seconds with the rest.
    func timeDisplay() -> String {
        let minutes = Int(timerManager.elapsedTime) / 60
        let seconds = Int(timerManager.elapsedTime) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack {
            //Display the Timer
            HStack{
                Spacer(minLength: 120)
                TextField ("", text: .constant(timeDisplay()))
                    .font(.largeTitle)
                    .padding()
                    .onTapGesture {
                        isEditing = true
                    }
                // Disable the TextField while editing
                    .disabled(isEditing)
                Spacer()
            }
            if isEditing {
                HStack{
                    //Minutes Picker Time Selection
                    Picker("",selection: $selectedMinutes) {
                        ForEach(0..<59){
                            Text("\($0) min")
                        }
                    }
                    .pickerStyle(.wheel)
                    .labelsHidden()
                    .onTapGesture {
                        //This is triggered when the user taps on the minutes picker
                        isEditing = false
                    }
                    
                    //Seconds Picker Time Selection
                    Picker("", selection: $selectedSeconds){
                        ForEach(0..<59) {
                            Text("\($0) sec")
                        }
                    }
                    .pickerStyle(.wheel)
                    .labelsHidden()
                    .onTapGesture {
                        //This is triggered when the user taps on the seconds picker
                        isEditing = false
                    }
                }
            }
            HStack {
                // Start Button
                Button(action: {
                    startTimer()
                }) {
                    
                    Image(systemName: "restart")
                    Text("Start")
                }
                .buttonStyle(.borderedProminent)
                .disabled(isTimerRunning)
                .padding(5)
                

                // Pause Button
                Button(action: {
                    stopTimer()
                }) {
                    Image(systemName: "pause.fill")
                    Text("Pause")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isTimerRunning)
                .padding(5)

                // Restart Button
                Button(action: {
                    resumeTimer()
                }) {
                    Image(systemName: "play.fill")
                    Text("Resume")
                }
                .buttonStyle(.borderedProminent)
                .disabled(isTimerRunning)
                .padding(5)
            }
        }
        .onReceive(timerManager.$elapsedTime) { _ in
            // Optionally handle updates when the timer changes
        }
    }
}



struct TimerView_Trial: View {
    var body: some View {
        TimerView()
    }
}

struct TimerView_Trial_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
