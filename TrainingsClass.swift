//
//  TrainingsClass.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 20.10.23.
//

import Foundation

import SwiftUI

import FirebaseFirestore

import Firebase

import FirebaseAuth


//Identifiable Struct for Exercise

struct Exercise: Identifiable, Hashable, Encodable, Decodable {
    var name : String
    var bodypart: String
    var information: String
    var execution: String
    var repetition : String = "4x12"
    var display: String = "dumbbells"
    var displayInstructions: String = "dumbbells"
    var videolink: String = ""
    var id = UUID()

}

// Routine Class for each part of the body

class Routine: ObservableObject {
    @Published var chest_exercises:[Exercise] = [
                benchPress, tricepsDumbbells, tricepsDips, pressDumbbells, tricepsCable, cableDown, cableUp, abs, bike
        ]
    @Published var back_exercises:[Exercise] = [
                pullDown, crossedPulldown, closedPulldown, hammerDumbbells, bicepsDumbbells, bicepsCurls, inversebicepsCurls, shouldersPress, bike
        ]
    @Published var potence_exercises:[Exercise] = [
                jumpBox, hikeUpkettlebells, pushUps, squatsCleanKettlebell, ballisticRow, americanSwing, abs, boxing, bike
        ]
    @Published var leg_exercises:[Exercise] = [
                deadlifts, squats, legExtension, legPress, jumpBox, calfRaises, bike
        ]
    
    //HIIT Exercises array
    @Published var hiit_exercises: [Exercise] = [
        burpees, jumpRope, wallballs, toesToBar, boxDips, plankHold, jumpBox, squatThrows, barbellGroundToOverhead, hikeUpkettlebells, americanSwing, burpees, boxing
    ]
    
    @Published var HIITSession1: [Exercise] = [jumpBox, squatThrows, barbellGroundToOverhead]
    
    @Published var HIITSession2: [Exercise] = [hikeUpkettlebells, americanSwing, burpees]
    
    @Published var HIITSession3: [Exercise] = [boxing]
    
    //Warm up Exercises array
    @Published var warm_up_exercises: [Exercise] = [
        jumpingJacks, armCircles, legSwings, highKnees, mountainClimbers
    ]
    @Published var warm_up_exercises_2: [Exercise] = [
        aSkips, hipRotations, legSwings, highKnees, neckRotations
    ]
    //Stretching Exercise arrays
    @Published var stretching_exercises: [Exercise] = [
        neckStretch, shoulderStretch, tricepsStretch, chestOpener, wristStretch, catCowStretch, hipFlexorStretch, seatedForwardStretch, quadricepsStretch, calfStretch
    ]
    @Published var new_routine: [Exercise] = []
    
    //Save data from the var new_routine in Firestore
    func addRoutinetoFirestore(exercise: Exercise){
        //check authentication
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        
        //declare reference to Firestore
        let db = Firestore.firestore()
        
        let ExerciseValues: [String: Any] = [
            "id": exercise.id.uuidString,
            "name": exercise.name,
            "bodypart": exercise.bodypart,
            "information": exercise.information,
            "execution": exercise.execution,
            "repetition": exercise.repetition,
            "display": exercise.display,
            "displayInstruction": exercise.displayInstructions,
            "videoLink": exercise.videolink
        ]
        
        db.collection("users").document(userID).collection("routines").document(exercise.id.uuidString).setData(ExerciseValues, merge: true)
    }
    
    func loadRoutinetoFirestore(){
        //authenticate with the userID
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        //reference to the database
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).collection("routines").getDocuments{
            snapshot, error in
            //check for errors
            if let error = error {
                print("Error getting documents \(error)")
            } else {
                // no error
                //check the userID
                print("Your REBT data for the user ID is: \(userID) has been loaded succesfully")
                //check if snapshot is nil
                if let snapshot = snapshot {
                    //Retrieve the documents
                    self.new_routine = snapshot.documents.compactMap { document in
                        let data = document.data()
                        let id = UUID(uuidString: data["id"] as? String ?? "") ?? UUID()
                        let name = data["name"] as? String ?? ""
                        let bodypart = data["bodypart"] as? String ?? ""
                        let information = data["information"] as? String ?? ""
                        let execution = data["execution"] as? String ?? ""
                        let repetition = data["repetition"] as? String ?? ""
                        let display = data["display"] as? String ?? ""
                        let displayInstructions = data["displayInstructions"] as? String ?? ""
                        let videolink = data["videolink"] as? String ?? ""
                        
                        return Exercise(name: name, bodypart: bodypart, information: information, execution: execution, repetition: repetition, display: display, displayInstructions: displayInstructions, videolink: videolink)

                    }
                }
                else {
                    print("Snapshot is nil")
                }
            }
        }
    }
    
    func deleteRoutinefromFirestore(exercise: Exercise){
        //authenticate with user
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User ID not authenticated")
            return
        }
        //reference to Firestore
        let db = Firestore.firestore()
        
        //Specify the document to delete
        db.collection("routines").document(exercise.id.uuidString).delete()

    }
    
}

//Create a new storage file within the document directory from the File Manager
private func getnew_routineFileURL() throws -> URL{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent("new_routineDataBase.json")
}


// Exercise Glossary Class for all the exercises

class ExerciseGlossary: ObservableObject {
    @Published var ExerciseGuide = [
            //Chest Exercises
            benchPress, closeGripPress, inclinePress, declinePress, wideGripBenchPress, smithMachineBenchPress, chestPressMachine,
            dumbbellPullover, inclineSmithMachinePress, standingCableFlyes, chestDips, cablePulldown, landminePress,pressDumbbells,
            cableDown, cableUp,
            // Triceps Exercises
            tricepsDumbbells, tricepsDips, tricepsCable,
            //Biceps Exercises
            bicepsDumbbells, bicepsCurls, inversebicepsCurls,
            //Shoulders Exercises
            shouldersPress,
            //Back Exercises
            pullDown, crossedPulldown, closedPulldown, hammerDumbbells,
            //Potence Exercises
            jumpBox, hikeUpkettlebells, pushUps, squatsCleanKettlebell, ballisticRow, americanSwing,
            //Leg Exercises
            deadlifts, squats, legExtension, legPress, calfRaises,
            //Abs Exercises
            abs,
            //Cardio Exercises
            boxing, bike
]}


//warmup exercises: jumpingJacks, armCircles, legSwings, highKnees, hipRotations, neckRotations, mountainClimbers, aSkips

let jumpingJacks = Exercise(
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
)

let armCircles = Exercise(
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

let legSwings = Exercise(
    name: "Leg Swings",
    bodypart: "Legs",
    information: """
Leg swings are a dynamic stretching exercise that targets the hip flexors, hamstrings, and quadriceps.
Variations:
1- Perform side-to-side leg swings to target the inner and outer thighs.
2- Increase or decrease the height of the leg swings for varying levels of flexibility and intensity.
3- Hold onto a stable surface for balance if needed.
""",
    execution: "Stand beside a sturdy surface for support. Swing one leg forward and backward in a controlled manner. After completing the desired number of swings, switch to the other leg. Focus on a smooth, controlled motion.",
    repetition: "30 seconds per leg", // Adjust duration based on fitness level
    display: "legSwings",
    displayInstructions: "legSwings2",
    videolink: "shorts/3l31E2cMGMk"
)

let highKnees = Exercise(
    name: "High Knees",
    bodypart: "Legs and Cardiovascular System",
    information: """
High knees are a cardio exercise that engages the lower body and elevates the heart rate.
Variations:
1- Increase the speed of the high knees for a more intense cardiovascular workout.
2- Focus on lifting the knees higher to engage the core muscles.
3- Perform high knees in place or while moving forward.
""",
    execution: "Stand with feet hip-width apart. Lift one knee towards your chest while quickly switching to lift the other knee. Continue the motion in a running-in-place manner. Pump your arms to enhance the cardiovascular benefits.",
    repetition: "60 seconds", // Adjust duration based on fitness level
    display: "highKnees",
    displayInstructions: "highKnees2",
    videolink: "shorts/0X0Q8wKLEfo"
)

let hipRotations = Exercise(
    name: "Hip Rotations",
    bodypart: "Core",
    information: """
Hip Rotations help improve hip mobility and flexibility.
Variations:
1- Perform the rotations in both clockwise and counterclockwise directions.
2- Gradually increase the range of motion as your flexibility improves.
3- Incorporate controlled breathing to enhance relaxation.
""",
    execution: "Lie on your back with knees bent, rotate your hips in a circular motion, keeping your upper body stable.",
    repetition: "3x20 (Clockwise and Counterclockwise)", // Adjust repetitions based on fitness level
    display: "hipRotations",
    displayInstructions: "hipRotations2",
    videolink: "shorts/1AcFl51wYuw"
)

let neckRotations = Exercise(
    name: "Neck Rotations",
    bodypart: "Neck",
    information: """
Neck Rotations help relieve tension and improve neck flexibility.
Variations:
1- Perform rotations in both clockwise and counterclockwise directions.
2- Gently tilt your head to each side during the rotation for added stretch.
3- Avoid forcing the movement; keep it smooth and controlled.
""",
    execution: "Sit or stand comfortably, slowly rotate your neck in a circular motion, first clockwise and then counterclockwise.",
    repetition: "3x15 (Clockwise and Counterclockwise)", // Adjust repetitions based on fitness level
    display: "neckRotations",
    displayInstructions: "neckRotations2",
    videolink: "shorts/rdbkup0jwAA"
)

let mountainClimbers = Exercise(
    name: "Mountain Climbers",
    bodypart: "Full Body",
    information: """
Mountain Climbers are a dynamic, full-body exercise with a focus on cardiovascular fitness.
Variations:
1- Increase the pace for a more intense cardio workout.
2- Bring your knees to your chest for added abdominal engagement.
3- Maintain a plank position for an isometric challenge.
""",
    execution: "Start in a plank position, alternate bringing your knees towards your chest in a running motion.",
    repetition: "3x30 (15 each leg)", // Adjust repetitions based on fitness level
    display: "mountainClimbers",
    displayInstructions: "mountainClimbers2",
    videolink: "shorts/BFUbeGXEcYk"
)

let aSkips = Exercise(
    name: "A Skips",
    bodypart: "Legs",
    information: """
A Skips are a plyometric exercise focusing on leg strength and coordination.
Variations:
1- Increase the height of each skip for a more challenging workout.
2- Maintain an upright posture throughout the exercise.
3- Perform the skips explosively for maximum benefit.
""",
    execution: "Stand with one knee raised, skip while driving the opposite knee upwards, alternating legs.",
    repetition: "3x20 (10 each leg)", // Adjust repetitions based on fitness level
    display: "aSkips",
    displayInstructions: "aSkips2",
    videolink: "shorts/NEBEQba4Fb8"
)



//hiit Exercises: burpees, jumpRope, wallballs, toesToBar, boxDips, plankHold, SquatThrows, BarbellGroundtoOverhead,

let burpees = Exercise(
    name: "Burpees",
    bodypart: "Full Body",
    information: """
Burpees are a full-body exercise that combines a squat, plank, push-up, and jump.
Variations:
1- Add a push-up after the plank position for an additional challenge.
2- Perform a tuck jump at the end of the movement to increase intensity.
3- Speed up the pace for a cardio-focused workout.
""",
    execution: "Start in a standing position, perform a squat, place your hands on the floor, kick your feet back into a plank position, do a push-up, return to the plank, jump your feet back to your hands, and explosively jump up from the squat position.",
    repetition: "3x15", // Adjust repetitions based on fitness level
    display: "burpees",
    displayInstructions: "burpeesInstructions",
    videolink: "shorts/isRKgI3OOPM"
)

let jumpRope = Exercise(
    name: "Jump Rope",
    bodypart: "Cardio",
    information: """
Jump rope is a cardiovascular exercise that improves coordination and endurance.
Variations:
1- Increase the speed of the jumps for a higher intensity workout.
2- Try different footwork patterns to target different muscle groups.
3- Perform double unders by rotating the rope twice under your feet with each jump.
""",
    execution: "Hold the handles of the jump rope, stand with feet together, and swing the rope over your head. Jump over the rope as it passes under your feet. Land softly and maintain a steady rhythm.",
    repetition: "5 minutes", // Adjust duration based on fitness level
    display: "jumpRope",
    displayInstructions: "jumpRopeInstructions",
    videolink: "shorts/A0cwbJ5inTo"
)

let wallballs = Exercise(
    name: "Wallballs",
    bodypart: "Legs, Core, Shoulders",
    information: """
Wallballs combine a squat with a medicine ball throw to target multiple muscle groups.
Variations:
1- Vary the weight of the medicine ball for different intensity levels.
2- Adjust the target height on the wall to change the throw trajectory.
3- Perform deeper squats for increased lower body engagement.
""",
    execution: "Hold a medicine ball at chest height, perform a squat, and explosively throw the ball against a wall at a specified target. Catch the ball and repeat the movement.",
    repetition: "4x20", // Adjust repetitions based on fitness level
    display: "wallballs",
    displayInstructions: "wallballsInstructions",
    videolink: "shorts/sz2ZeQ5PUdg"
)

let toesToBar = Exercise(
    name: "Toes to Bar",
    bodypart: "Core",
    information: """
Toes to Bar is a core exercise that involves lifting your toes to touch the pull-up bar.
Variations:
1- Start with knees to chest if toes to bar is too challenging initially.
2- Focus on controlled movements to engage the core muscles effectively.
3- Increase difficulty by slowing down the movement or adding leg raises.
""",
    execution: "Hang from a pull-up bar with an overhand grip. Engage your core and lift your toes to touch the bar. Lower your legs back down with control.",
    repetition: "4x12", // Adjust repetitions based on fitness level
    display: "",
    displayInstructions: "",
    videolink: ""
)

let boxDips = Exercise(
    name: "Box Dips",
    bodypart: "Triceps, Chest, Shoulders",
    information: """
Box dips are a compound exercise that targets the triceps, chest, and shoulders.
Variations:
1- Adjust the height of the box to change the difficulty level.
2- Lean forward slightly to engage the chest muscles more.
3- Keep the elbows close to the body for proper triceps activation.
""",
    execution: "Place your hands on a box behind you, fingers facing forward. Lower your body by bending your elbows until they reach a 90-degree angle. Push back up to the starting position.",
    repetition: "3x15", // Adjust repetitions based on fitness level
    display: "boxDips",
    displayInstructions: "boxDipsInstructions",
    videolink: "shorts/Mo5uPl2_XGQ"
)

let plankHold = Exercise(
    name: "Plank Hold",
    bodypart: "Core, Shoulders",
    information: """
The plank hold is an isometric exercise that targets the core and shoulders.
Variations:
1- Perform a high plank with arms fully extended or a low plank on forearms.
2- Engage the core by pulling the belly button toward the spine.
3- Maintain a straight line from head to heels throughout the hold.
""",
    execution: "Start in a plank position with either arms fully extended or on forearms. Keep your body in a straight line from head to heels, engaging your core. Hold for the desired duration.",
    repetition: "3x60 seconds", // Adjust duration based on fitness level
    display: "plank",
    displayInstructions: "plankInstructions",
    videolink: "shorts/v25dawSzRTM"
)

let squatThrows = Exercise(
    name: "Squat Throws",
    bodypart: "Full Body",
    information: """
Squat Throws involve explosive movements, engaging various muscle groups.
Variations:
1- Use a medicine ball for added resistance.
2- Increase the throwing height for a more intense workout.
3- Focus on controlled landings to enhance stability.
""",
    execution: "Begin in a squat position holding a weighted object, explosively extend your hips and throw the object upward, then catch and return to the squat position.",
    repetition: "3x12", // Adjust repetitions based on fitness level
    display: "squatThrows",
    displayInstructions: "squatThrowsInstructions",
    videolink: "shorts/jIBkXDJDTgI"
)

let barbellGroundToOverhead = Exercise(
    name: "Barbell Ground to Overhead",
    bodypart: "Full Body",
    information: """
Barbell Ground to Overhead is a compound movement engaging the lower and upper body.
Variations:
1- Perform a clean and press for a more comprehensive workout.
2- Adjust the weight to match your fitness level.
3- Focus on proper form throughout the movement.
""",
    execution: "Start with a barbell on the ground, perform a clean and lift the barbell overhead, fully extending your body. Lower the barbell back to the ground with control.",
    repetition: "3x10", // Adjust repetitions based on fitness level
    display: "barbellGround",
    displayInstructions: "barbellGroundInstructions",
    videolink: "shorts/G7nctRw2xC0"
)



//stretching exercises: neckStretch, shoulderStretch, tricepsStretch, chestOpener, wristStretch, catCowStretch, hipFlexorStretch, seatedForwardStretch, quadricepsStretch, calfStretch

let neckStretch = Exercise(
    name: "Neck Stretch",
    bodypart: "Neck",
    information: """
The neck stretch helps release tension in the neck muscles.
Variations:
1- Gently tilt your head from side to side to target different neck muscles.
2- Perform slow, circular motions with your head for a dynamic stretch.
3- Avoid overstretching and move within a comfortable range of motion.
""",
    execution: "Sit or stand with a straight back. Slowly tilt your head to one side, bringing your ear toward your shoulder. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "neckStretch",
    displayInstructions: "neckStretchInstructions",
    videolink: "shorts/fWa_tgaytMo"
)

let shoulderStretch = Exercise(
    name: "Shoulder Stretch",
    bodypart: "Shoulders",
    information: """
The shoulder stretch helps improve flexibility and mobility in the shoulders.
Variations:
1- Bring your arm across your chest at different angles for varied stretches.
2- Gently press on your elbow to intensify the stretch.
3- Perform slow, controlled movements for an active stretch.
""",
    execution: "Extend one arm across your chest. Use the opposite hand to gently press the arm closer to your chest. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "shoulderStretch",
    displayInstructions: "shoulderStretchInstructions",
    videolink: "shorts/V7iuvkOJ8_o"
)

let tricepsStretch = Exercise(
    name: "Triceps Stretch",
    bodypart: "Triceps",
    information: """
The triceps stretch targets the muscles at the back of your upper arm.
Variations:
1- Bring your hand down your back for a deeper stretch.
2- Use the opposite hand to gently press on your bent elbow.
3- Perform the stretch with a straight and bent arm for different focuses.
""",
    execution: "Raise one arm overhead, bending the elbow and reaching your hand down your back. Use the opposite hand to gently press on the bent elbow. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "tricepsStretch",
    displayInstructions: "tricepsStretchInstructions",
    videolink: "watch?app=desktop&v=zzvDO56B0HE"
)

let chestOpener = Exercise(
    name: "Chest Opener",
    bodypart: "Chest",
    information: """
The chest opener stretch helps counteract the effects of prolonged sitting and hunching.
Variations:
1- Perform the stretch against a wall for added stability.
2- Interlace your fingers behind your back to deepen the stretch.
3- Focus on opening the chest and squeezing the shoulder blades together.
""",
    execution: "Stand with feet hip-width apart. Clasp your hands behind your back and straighten your arms. Lift your arms slightly, opening your chest. Hold for a gentle stretch.",
    repetition: "3x30 seconds",
    display: "chest",
    displayInstructions: "chestOpenerInstructions",
    videolink: "watch?app=desktop&v=izhWC2qwZk0"
)

let wristStretch = Exercise(
    name: "Wrist Stretch",
    bodypart: "Wrists",
    information: """
The wrist stretch helps improve flexibility and alleviate tension in the wrists.
Variations:
1- Perform circular motions with your wrists for added mobility.
2- Gently pull back on your fingers to stretch the front of your wrists.
3- Rotate your wrists in both directions for a comprehensive stretch.
""",
    execution: "Extend one arm forward with the palm facing down. Use the opposite hand to gently press on the fingers, stretching the wrist. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "",
    displayInstructions: "",
    videolink: ""
)

let catCowStretch = Exercise(
    name: "Cat-Cow Stretch",
    bodypart: "Spine",
    information: """
The cat-cow stretch is a dynamic movement that helps improve spinal flexibility.
Variations:
1- Move between the cat and cow positions at a pace that feels comfortable.
2- Focus on arching and rounding your back to engage different spinal muscles.
3- Coordinate the movement with your breath for a mindful stretch.
""",
    execution: "Start on your hands and knees. Inhale, arch your back, and lift your head (cow position). Exhale, round your back, and tuck your chin to your chest (cat position). Repeat in a flowing motion.",
    repetition: "3x15",
    display: "",
    displayInstructions: "",
    videolink: ""
)

let hipFlexorStretch = Exercise(
    name: "Hip Flexor Stretch",
    bodypart: "Hips",
    information: """
The hip flexor stretch targets the muscles at the front of the hips.
Variations:
1- Perform the stretch with a lunge position for a deeper stretch.
2- Engage your core to stabilize your spine during the stretch.
3- Gradually increase the depth of the stretch as flexibility improves.
""",
    execution: "Kneel on one knee with the other foot forward, forming a lunge position. Shift your weight forward, feeling a stretch in the front of the hip on the kneeling leg. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "",
    displayInstructions: "",
    videolink: ""
)

let seatedForwardStretch = Exercise(
    name: "Seated Forward Stretch",
    bodypart: "Lower Back, Hamstrings",
    information: """
The seated forward stretch targets the lower back and hamstrings.
Variations:
1- Perform the stretch with a straight back for a hamstring focus.
2- Round your back and reach towards your toes to engage the lower back.
3- Use a strap or towel to reach your feet if flexibility is limited.
""",
    execution: "Sit with your legs extended in front of you. Hinge at your hips and reach forward towards your toes. Hold for a gentle stretch. Keep your back straight or round it for different emphases.",
    repetition: "3x30 seconds",
    display: "",
    displayInstructions: "",
    videolink: ""
)

let quadricepsStretch = Exercise(
    name: "Quadriceps Stretch",
    bodypart: "Quadriceps",
    information: """
The quadriceps stretch targets the muscles at the front of the thighs.
Variations:
1- Perform the stretch standing or lying down for different angles.
2- Use a wall or support for balance during the standing version.
3- Pull your foot towards your glutes to deepen the stretch.
""",
    execution: "Stand on one leg and bring the other heel towards your glutes. Hold your foot with your hand and keep your knees close together. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "",
    displayInstructions: "",
    videolink: ""
)

let calfStretch = Exercise(
    name: "Calf Stretch",
    bodypart: "Calves",
    information: """
The calf stretch targets the muscles at the back of the lower legs.
Variations:
1- Perform the stretch with a bent or straight knee for different emphasis.
2- Use a wall or support for balance during the standing version.
3- Gradually increase the stretch by leaning forward or backward.
""",
    execution: "Stand facing a wall with one foot forward and the other back. Keep the back leg straight, heel on the ground, and bend the front knee. Hold for a gentle stretch. Repeat on the other side.",
    repetition: "3x30 seconds",
    display: "",
    displayInstructions: "",
    videolink: ""
)


//ChestExercises

let benchPress = Exercise (
                        name: "Bench Press",
            bodypart: "Chest",
            information: """
This exercise focuses on the pectorals and places secondary emphasis on the triceps, anterior deltoids, serratus, an coracobrachialis.
Variations:
1- Arch your back to work the more powerful lower pectorals and lift heavier loads. However, perform this variation carefully to reduce the likelihood to injury to your back.
2- Press the barbell with your elbows at your sides to focus more on the anterior deltoids.
3- Vary the width of your grip: a narrow grip shifts the focus to the inner pectorals and a very wide grip shifts the focus to the outer pectorals.
4- Lower the bar to the lower chest to work the lower pectorals, to the middle of the chest to work the medial pectorals and to the upper chest to work the upper pectorals.
5- Raise your feet from the floor by curling your legs over your abdominals if you have back problems
""",
        execution: "To execute a bench press, lie on a bench with feet planted, grip the barbell slightly wider than shoulder-width, and unrack it above your chest. Lower the bar slowly, keeping elbows at a 45-degree angle. Breathe in while lowering. Push the bar up, extending arms, and exhale. Perform desired reps, ensuring proper form to prevent injury. Begin with manageable weight and progressively increase for strength gains, fitting well into your fitness routine.",
                repetition: "4x12",
            
        display: "bench-press",
        displayInstructions: "benchpressIns1",
        videolink: "shorts/i-gLOirnPaU"

)

let closeGripPress = Exercise (
    name: "Close-Grip Bench Press",
    bodypart: "Chest",
    information: """
    The close-grip bench press is a variation of the bench press that targets the triceps while also engaging the chest and shoulders. It's performed with a narrower grip than the traditional bench press.

    Variations:
    1- Adjust the grip width for different levels of triceps and chest engagement.
    2- Focus on maintaining proper form, especially with the elbows close to your body, to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on a flat bench with your feet on the ground. Grip the barbell with your hands close together, narrower than shoulder-width. Lift the bar off the rack and slowly lower it to your chest. Push the bar back up to the starting position while exhaling. Perform the exercise with proper form and start with manageable weight.",
    repetition: "4x12",
    display: "bench-press",
    displayInstructions: "closeGripInstruc"
)

let inclinePress = Exercise (
    name: "Incline Bench Press",
    bodypart: "Chest",
    information: """
    The incline bench press is a variation of the bench press that targets the upper chest muscles. It's performed on an inclined bench to change the angle of engagement.

    Variations:
    1- Adjust the angle of the bench for different levels of upper chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on an inclined bench with your feet on the ground. Grip the barbell with your hands slightly wider than shoulder-width apart. Lift the bar off the rack and slowly lower it to your upper chest. Push the bar back up to the starting position while exhaling. Perform the exercise with proper form and start with manageable weight.",
    repetition: "4x12",
    display: "inclineBenchPress",
    displayInstructions: "inclinePressInstruc"
)

let declinePress = Exercise (
    name: "Decline Bench Press",
    bodypart: "Chest",
    information: """
    The decline bench press is a variation of the bench press that targets the lower chest muscles. It's performed on a declined bench to change the angle of engagement.

    Variations:
    1- Adjust the angle of the bench for different levels of lower chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on a declined bench with your feet on the ground. Grip the barbell with your hands slightly wider than shoulder-width apart. Lift the bar off the rack and slowly lower it to your lower chest. Push the bar back up to the starting position while exhaling. Perform the exercise with proper form and start with manageable weight.",
    repetition: "4x12",
    display: "declinePress",
    displayInstructions: "declinePressInstruc"
)

let wideGripBenchPress = Exercise (
    name: "Wide-Grip Bench Press",
    bodypart: "Chest",
    information: """
    The wide-grip bench press is a variation of the bench press that involves a wider hand placement on the barbell. It focuses on the outer chest muscles.

    Variations:
    1- Adjust the grip width for different levels of chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on a flat bench with your feet on the ground. Grip the barbell with your hands wider than shoulder-width apart. Lift the bar off the rack and slowly lower it to your chest. Push the bar back up to the starting position while exhaling. Perform the exercise with proper form and start with manageable weight.",
    repetition: "4x12",
    display: "bench-press",
    displayInstructions: "wideGripPressInstruc"
)

let smithMachineBenchPress = Exercise (
    name: "Smith Machine Bench Press",
    bodypart: "Chest",
    information: """
    The Smith machine bench press is a variation of the bench press that provides stability and controlled movement. It's performed using a Smith machine.

    Variations:
    1- Adjust the bench and grip width for different levels of chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Position yourself on the Smith machine bench with your back against the bench. Grip the barbell with your hands slightly wider than shoulder-width apart. Lift the bar off the guide rails and slowly lower it to your chest. Push the barbell back up to the starting position while exhaling. Perform the exercise with proper form and start with manageable weight.",
    repetition: "4x12",
    display: "bench-press",
    displayInstructions: "smithMachineBenchPressInstruc"
)

let chestPressMachine = Exercise (
    name: "Chest Press Machine",
    bodypart: "Chest",
    information: """
    The chest press machine is a piece of gym equipment that simulates a bench press motion and targets the chest muscles.

    Variations:
    1- Adjust the seat and handles on the machine for your settings.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Adjust the seat and handles on the machine to your desired settings. Sit on the machine with your back against the backrest and grip the handles. Push the handles forward until your arms are fully extended. Return the handles to the starting position, flexing your chest muscles. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "chest-press",
    displayInstructions: "chestPressInstruc"
)

let dumbbellPullover = Exercise (
    name: "Dumbbell Pullover",
    bodypart: "Chest",
    information: """
    The dumbbell pullover targets the chest, lats, and triceps. It's performed by lying on a bench with only your upper back on the bench and extending your arms over your chest.

    Variations:
    1- Adjust the weight of the dumbbell for different levels of chest and back engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on a bench with only your upper back on the bench. Hold a dumbbell with both hands extended over your chest. Lower the dumbbell backward in a semicircular motion until your arms are parallel to the ground. Return the dumbbell to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "dumbbells",
    displayInstructions: "dumbbellPullover"
)

let inclineSmithMachinePress = Exercise (
    name: "Incline Smith Machine Press",
    bodypart: "Chest",
    information: """
    The incline Smith machine press is a variation of the Smith machine bench press that targets the upper chest. It provides stability and control during the exercise.

    Variations:
    1- Adjust the bench angle and grip width for different levels of upper chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Adjust the bench on the Smith machine to an incline angle. Grip the bar with your hands slightly wider than shoulder-width apart. Lift the bar off the guide rails and slowly lower it to your upper chest. Push the barbell back up to the starting position while exhaling. Perform the exercise with proper form and start with manageable weight.",
    repetition: "4x12",
    display: "incline-smith-machine",
    displayInstructions: "inclineSmithMachineInstruc"
)

let standingCableFlyes = Exercise (
    name: "Standing Cable Flyes",
    bodypart: "Chest",
    information: """
    Standing cable flyes are a cable machine exercise that targets the chest muscles from a different angle.

    Variations:
    1- Adjust the cable pulleys and handle height for different levels of chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Adjust the cable pulleys to chest height. Stand in the middle and hold one handle in each hand. Extend your arms forward and slightly outward. Bring your hands together in front of your chest, squeezing your chest muscles. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "cable-flyes",
    displayInstructions: "standingCableFlyesInstruc"
)

let chestDips = Exercise (
    name: "Chest Dips",
    bodypart: "Chest",
    information: """
    Chest dips are a variation of the dip exercise that targets the chest, triceps, and shoulders.

    Variations:
    1- Adjust the dip bars and body positioning to emphasize chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand between parallel bars. Lean forward slightly to target the chest. Lower your body by bending your arms until your shoulders are below your elbows. Push your body back up to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "chest-dips",
    displayInstructions: "chestDipsInstruc"
)

let cablePulldown = Exercise (
    name: "Cable Pulldown",
    bodypart: "Chest",
    information: """
    The cable pulldown exercise is typically used to target the back, but it can also engage the chest muscles when performed with a wide grip.

    Variations:
    1- Attach a wide-grip handle to the cable machine for chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Attach a wide-grip handle to the cable machine. Sit on the machine with your thighs secured. Hold the handle with a wide grip. Pull the handle down to your chest, squeezing your chest muscles. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "pulldownmachine",
    displayInstructions: "cablePulldownInstruc"
)

let landminePress = Exercise (
    name: "Landmine Press",
    bodypart: "Chest",
    information: """
    The landmine press is a unique exercise that targets the chest and shoulders. It involves lifting one end of a barbell while the other end is fixed in a landmine attachment.

    Variations:
    1- Adjust the attachment's positioning and grip width for different levels of chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Secure the landmine attachment. Load one end of the barbell. Stand with your back to the attachment, holding the loaded end of the barbell with both hands at chest level. Press the barbell forward until your arms are fully extended. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "landmine",
    displayInstructions: "landminePressInstruc"
)

let pressDumbbells = Exercise (
    name: "Dumbbell Chest Press",
    bodypart: "Chest",
    information: """
    The dumbbell chest press is a chest exercise performed with dumbbells, targeting the pectoral muscles.

    Variations:
    1- Adjust the weight of the dumbbells for different levels of chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on a flat bench with your feet on the ground. Hold a dumbbell in each hand at chest level. Press the dumbbells upward until your arms are fully extended. Slowly lower the dumbbells to your chest. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "dumbells-press",
    displayInstructions: "dumbbellPressInstruc"
)

let cableDown = Exercise (
    name: "Cable Down",
    bodypart: "Chest",
    information: """
    The cable pressdown is a cable machine exercise that primarily targets the triceps but also engages the chest.

    Variations:
    1- Attach a straight bar to the high pulley of the cable machine for chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Attach a straight bar to the high pulley of the cable machine. Stand facing the machine and hold the bar with hands close together. Push the bar down to chest level, extending your arms. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "cables",
    displayInstructions: "cableDownInstruc"
)

let cableUp = Exercise (
    name: "Cable Up",
    bodypart: "Chest",
    information: """
    The cable upright row is a cable machine exercise that primarily targets the deltoid muscles but also engages the chest and trapezius.

    Variations:
    1- Attach a straight bar to the high pulley of the cable machine for chest engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Attach a straight bar to the high pulley of the cable machine. Stand facing the machine and hold the bar with hands close together. Pull the bar upward toward your chin, keeping it close to your body. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "cables",
    displayInstructions: "cableUpInstruc"
)

// Triceps Exercises

let tricepsDumbbells = Exercise (
    name: "Triceps Dumbbell Extension",
    bodypart: "Triceps",
    information: """
    Triceps dumbbell extension is an effective exercise to target the triceps. It's performed with a dumbbell, primarily engaging the triceps.

    Variations:
    1- Adjust the weight of the dumbbell for different levels of triceps engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit on a bench with a backrest, holding a dumbbell with both hands overhead. Lower the dumbbell behind your head, keeping your upper arms stationary. Extend your arms, raising the dumbbell back to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "dumbbells"
)

let tricepsDips = Exercise (
    name: "Triceps Dips",
    bodypart: "Triceps",
    information: """
    Triceps dips are an effective exercise to target the triceps, shoulders, and chest.

    Variations:
    1- Adjust the dip bars and body positioning to emphasize triceps engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand between parallel bars. Lower your body by bending your arms until your shoulders are below your elbows. Push your body back up to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "chest-dips"
)

let tricepsCable = Exercise (
    name: "Triceps Cable Pushdown",
    bodypart: "Triceps",
    information: """
    Triceps cable pushdown is a cable machine exercise that primarily targets the triceps.

    Variations:
    1- Attach a straight bar or rope handle to the high pulley of the cable machine.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Attach a straight bar or rope handle to the high pulley of the cable machine. Stand facing the machine and grip the bar or handle. Push the bar down to full extension, extending your triceps. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "triceps-cable"
)

// Biceps Exercises

let bicepsDumbbells = Exercise (
    name: "Biceps Dumbbell Curls",
    bodypart: "Biceps",
    information: """
    Biceps dumbbell curls are a classic exercise to target the biceps. They are performed with dumbbells and primarily engage the biceps.

    Variations:
    1- Adjust the weight of the dumbbells for different levels of biceps engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, holding a dumbbell in each hand with arms fully extended. Curl the dumbbells toward your shoulders while keeping your upper arms stationary. Lower the dumbbells back to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "biceps_dumb"
)

let bicepsCurls = Exercise (
    name: "Biceps Barbell Curls",
    bodypart: "Biceps",
    information: """
    Biceps barbell curls are a classic exercise to target the biceps. They are performed with a barbell and primarily engage the biceps.

    Variations:
    1- Adjust the weight of the barbell for different levels of biceps engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, holding a barbell with hands shoulder-width apart and arms fully extended. Curl the barbell toward your shoulders while keeping your upper arms stationary. Lower the barbell back to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "barbellcurl"
)

let inversebicepsCurls = Exercise (
    name: "Inverse Biceps Curls",
    bodypart: "Biceps",
    information: """
    Inverse biceps curls are a variation of the classic biceps curl that targets the biceps from a different angle.

    Variations:
    1- Adjust the weight of the dumbbells for different levels of biceps engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, holding a dumbbell in each hand with arms fully extended and palms facing backward. Curl the dumbbells toward your shoulders while keeping your upper arms stationary. Lower the dumbbells back to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "barbellcurl"
)

// Shoulders Exercises

let shouldersPress = Exercise (
    name: "Shoulder Press",
    bodypart: "Shoulders",
    information: """
    The shoulder press is a classic exercise that primarily targets the deltoid muscles. It's commonly performed with a barbell or dumbbells.

    Variations:
    1- Adjust the weight of the barbell or dumbbells for different levels of shoulder engagement.
    2- Use a barbell or dumbbells, depending on your preference and equipment availability.
    3- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit or stand with your back straight and core engaged. Hold a barbell or dumbbells at shoulder level. Press the weight overhead until your arms are fully extended. Lower the weight back to shoulder level. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "dumbells-press"
)

//Back Exercises

let pullDown = Exercise (
    name: "Lat Pulldown",
    bodypart: "Back",
    information: """
    The lat pulldown is an exercise that targets the latissimus dorsi muscles in your back. It's performed using a cable machine with a wide grip bar or handle.

    Variations:
    1- Adjust the weight and grip width for different levels of back engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit down on the lat pulldown machine with your knees secured under the pads. Grip the bar or handle with your hands wider than shoulder-width apart. Pull the bar down to your chest, squeezing your back muscles. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "lat-pulldown"
)

let crossedPulldown = Exercise (
    name: "Crossed Lat Pulldown",
    bodypart: "Back",
    information: """
    The crossed lat pulldown is a variation of the lat pulldown exercise that targets the back from a different angle.

    Variations:
    1- Adjust the weight and grip width for different levels of back engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit down on the lat pulldown machine with your knees secured under the pads. Grip the bar or handle with your hands crossed in front of you. Pull the bar down to your chest, squeezing your back muscles. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "lat-pulldown"
)

let closedPulldown = Exercise (
    name: "Closed-Grip Lat Pulldown",
    bodypart: "Back",
    information: """
    The closed-grip lat pulldown is a variation of the lat pulldown exercise that targets the back with a narrower grip.

    Variations:
    1- Adjust the weight and grip width for different levels of back engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit down on the lat pulldown machine with your knees secured under the pads. Grip the bar or handle with your hands closer together. Pull the bar down to your chest, squeezing your back muscles. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "closedpulldown"
)

let hammerDumbbells = Exercise (
    name: "Hammer Dumbbell Curl",
    bodypart: "Arms",
    information: """
    The hammer dumbbell curl targets the biceps and brachialis muscles. It's performed with dumbbells in a neutral grip (palms facing each other).

    Variations:
    1- Adjust the weight of the dumbbells for different levels of biceps and brachialis engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, holding a dumbbell in each hand with palms facing each other. Curl the dumbbells toward your shoulders while keeping your upper arms stationary. Lower the dumbbells back to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "dumbbells"
)

//Potence Exercises

let jumpBox = Exercise (
    name: "Box Jumps",
    bodypart: "Legs",
    information: """
    Box jumps are an explosive leg exercise that targets the quadriceps and glutes. They also improve explosive power and agility.

    Variations:
    1- Adjust the height of the box for different levels of difficulty.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand in front of a sturdy box or platform. Bend your knees and jump onto the box, landing softly with knees slightly bent. Stand up straight on top of the box, then step or jump back down to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "jump-box"
)

let hikeUpkettlebells = Exercise (
    name: "Kettlebell Hike Swings",
    bodypart: "Legs",
    information: """
    Kettlebell hike swings are a dynamic leg exercise that engages the hamstrings, glutes, and lower back. They also improve hip hinge movement.

    Variations:
    1- Adjust the weight of the kettlebell for different levels of difficulty.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet hip-width apart, holding a kettlebell between your legs with both hands. Hinge at your hips, swing the kettlebell back through your legs, then thrust your hips forward to swing the kettlebell to shoulder level. Swing it back down and repeat. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "kettlebell"
)

let pushUps = Exercise (
    name: "Push-Ups",
    bodypart: "Chest and Triceps",
    information: """
    Push-ups are a classic bodyweight exercise that targets the chest, triceps, and shoulders. They also engage the core.

    Variations:
    1- Adjust hand positioning for different levels of chest and triceps engagement.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Start in a plank position with your hands shoulder-width apart. Lower your body by bending your arms until your chest touches the ground. Push your body back up to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "push-ups"
)

let squatsCleanKettlebell = Exercise (
    name: "Kettlebell Squat Clean",
    bodypart: "Legs and Shoulders",
    information: """
    Kettlebell squat cleans are a compound exercise that engages the legs and shoulders. It also improves explosive strength and coordination.

    Variations:
    1- Adjust the weight of the kettlebell for different levels of difficulty.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet hip-width apart, holding a kettlebell between your legs with both hands. Perform a squat, then explode up, using your hips and legs to clean the kettlebell to shoulder level. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "kettlebell"
)

let ballisticRow = Exercise (
    name: "Ballistic Rows",
    bodypart: "Back and Shoulders",
    information: """
    Ballistic rows are a challenging back and shoulder exercise that focuses on explosive rowing movements.

    Variations:
    1- Adjust the weight of the dumbbell or kettlebell for different levels of difficulty.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, holding a dumbbell or kettlebell in one hand. Perform a powerful rowing motion, pulling the weight up to your shoulder. Lower the weight back down in a controlled manner. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "kettlebell"
)

let americanSwing = Exercise (
    name: "American Kettlebell Swing",
    bodypart: "Legs and Shoulders",
    information: """
    The American kettlebell swing is a dynamic exercise that engages the legs, shoulders, and core. It's a full-body workout.

    Variations:
    1- Adjust the weight of the kettlebell for different levels of difficulty.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, holding a kettlebell with both hands. Swing the kettlebell overhead with a straight arm, fully extending your hips and knees. Swing the kettlebell back down through your legs. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "kettlebell"
)

//Leg Exercises

let deadlifts = Exercise (
    name: "Deadlifts",
    bodypart: "Legs and Lower Back",
    information: """
    Deadlifts are a compound exercise that target the legs, lower back, and various muscle groups. They also improve overall strength and power.

    Variations:
    1- Adjust the weight on the barbell or use different types of deadlifts (conventional, sumo, Romanian, etc.).
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet hip-width apart, bending at your hips and knees to lower down and grip the barbell. Keep your back straight and chest up. Lift the barbell by straightening your hips and knees, keeping it close to your body. Lower it back down to the ground with control. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "deadlifts"
)

let squats = Exercise (
    name: "Squats",
    bodypart: "Legs",
    information: """
    Squats are a fundamental leg exercise that primarily target the quadriceps, hamstrings, and glutes. They also engage the core and lower back.

    Variations:
    1- Adjust the weight by using barbells, dumbbells, or bodyweight squats.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with your feet shoulder-width apart, keeping your back straight and chest up. Bend your knees and hips to lower your body, keeping your back straight. Lower down until your thighs are parallel to the ground or below. Push back up to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "squats"
)

let legExtension = Exercise (
    name: "Leg Extensions",
    bodypart: "Legs",
    information: """
    Leg extensions target the quadriceps muscles in the front of the thighs.

    Variations:
    1- Adjust the weight on the leg extension machine.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit on the leg extension machine with your legs under the padded bar. Extend your legs to lift the weight. Slowly return to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "leg-curl"
)

let legPress = Exercise (
    name: "Leg Press",
    bodypart: "Legs",
    information: """
    The leg press is a compound exercise that primarily targets the quadriceps, hamstrings, and glutes. It's performed on a leg press machine.

    Variations:
    1- Adjust the weight on the leg press machine.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Sit on the leg press machine with your feet shoulder-width apart on the platform. Push the weight upward by extending your legs. Lower the weight back down to the starting position. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "leg-press"
)

let calfRaises = Exercise (
    name: "Calf Raises",
    bodypart: "Calves",
    information: """
    Calf raises are an exercise that targets the calf muscles.

    Variations:
    1- Use a calf raise machine, a Smith machine, or dumbbells for resistance.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with the balls of your feet on a raised surface (such as a step). Raise your heels as high as possible by pushing through the balls of your feet. Lower your heels below the level of the step for a stretch. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "seated-calf-raise"
)

//Abs Exercises
let abs = Exercise (
    name: "Abdominal Crunches",
    bodypart: "Abs",
    information: """
    Abdominal crunches are a core exercise that specifically target the rectus abdominis muscle, commonly known as the "six-pack."

    Variations:
    1- Use different angles or equipment, such as decline bench crunches or stability balls.
    2- Maintain proper form with controlled movements to maximize the effectiveness of this exercise.

    """,
    execution: "Lie on your back with your knees bent and feet flat on the floor. Place your hands behind your head or across your chest. Lift your head and shoulders off the ground by contracting your abs. Exhale as you crunch upward. Inhale as you lower back down. Perform the exercise with proper form and control.",
    repetition: "4x12",
    display: "abs-crunches"
)

//Cardio
let boxing = Exercise (
    name: "Boxing",
    bodypart: "Cardio and Upper Body",
    information: """
    Boxing is a high-intensity cardio and upper body workout that involves various punches, footwork, and defensive movements.

    Variations:
    1- Incorporate different boxing techniques, such as jabs, hooks, uppercuts, and combinations.
    2- Use a punching bag or shadowboxing for training.
    3- Maintain proper form and focus on technique to maximize the effectiveness of this exercise.

    """,
    execution: "Stand with proper boxing stance, hands up to protect your face. Practice various punches and combinations, moving around to simulate a match. Focus on form, speed, and power in your punches. Incorporate footwork and defensive maneuvers. Perform the exercise with proper technique and control.",
    repetition: "3 rounds of 3 minutes each",
    display: "boxing"
)

let bike = Exercise (
    name: "Stationary Bike",
    bodypart: "Cardio and Lower Body",
    information: """
    A stationary bike provides a low-impact cardio workout that primarily targets the lower body, including the quadriceps, hamstrings, and calves.

    Variations:
    1- Adjust the resistance and speed on the stationary bike.
    2- Incorporate interval training or steady-state cardio.
    3- Maintain proper form and pedal with control to maximize the effectiveness of this exercise.

    """,
    execution: "Sit on the stationary bike with your feet secured in the pedals. Start pedaling, adjusting the resistance as needed. You can do steady-state cardio or interval training. Focus on maintaining a steady pedal stroke and proper posture. Perform the exercise with proper form and control.",
    repetition: "30 minutes",
    display: "stationary-bike"
)
