import Foundation
import SwiftData

@Model
final class Exercise {
    var name: String
    var sectionRaw: Int
    var sortOrder: Int
    var modeRaw: String?

    // Strength fields
    var sets: Int?
    var reps: Int?
    var weight: Double?

    // Cardio fields
    var durationMinutes: Double?
    var distanceKm: Double?
    var intensityRaw: String?
    var notes: String?

    var day: WorkoutDay?

    var section: ExerciseSection {
        get { ExerciseSection(rawValue: sectionRaw) ?? .main }
        set { sectionRaw = newValue.rawValue }
    }

    var intensity: Intensity? {
        get {
            guard let raw = intensityRaw else { return nil }
            return Intensity(rawValue: raw)
        }
        set { intensityRaw = newValue?.rawValue }
    }

    var mode: WorkoutMode {
        get {
            if let modeRaw, let storedMode = WorkoutMode(rawValue: modeRaw) {
                return storedMode
            }

            if distanceKm != nil || intensityRaw != nil {
                return .cardio
            }

            if durationMinutes != nil {
                return section == .main ? .cardio : .mobility
            }

            return .strength
        }
        set { modeRaw = newValue.rawValue }
    }

    init(
        name: String,
        section: ExerciseSection,
        mode: WorkoutMode? = nil,
        sortOrder: Int = 0,
        sets: Int? = nil,
        reps: Int? = nil,
        weight: Double? = nil,
        durationMinutes: Double? = nil,
        distanceKm: Double? = nil,
        intensity: Intensity? = nil,
        notes: String? = nil
    ) {
        self.name = name
        self.sectionRaw = section.rawValue
        self.sortOrder = sortOrder
        self.modeRaw = mode?.rawValue
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.durationMinutes = durationMinutes
        self.distanceKm = distanceKm
        self.intensityRaw = intensity?.rawValue
        self.notes = notes
    }
}
