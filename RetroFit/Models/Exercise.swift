import Foundation
import SwiftData

@Model
final class Exercise {
    var name: String
    var sectionRaw: Int
    var sortOrder: Int

    // Strength fields
    var sets: Int?
    var reps: Int?
    var weight: Double?

    // Cardio fields
    var durationMinutes: Double?
    var distanceKm: Double?
    var intensityRaw: String?

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

    init(
        name: String,
        section: ExerciseSection,
        sortOrder: Int = 0,
        sets: Int? = nil,
        reps: Int? = nil,
        weight: Double? = nil,
        durationMinutes: Double? = nil,
        distanceKm: Double? = nil,
        intensity: Intensity? = nil
    ) {
        self.name = name
        self.sectionRaw = section.rawValue
        self.sortOrder = sortOrder
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.durationMinutes = durationMinutes
        self.distanceKm = distanceKm
        self.intensityRaw = intensity?.rawValue
    }
}
