struct Boat {
    let holdTime: Int
    
    func distanceTravelled(in time: Int) -> Int {
        let travelTime = (time - holdTime)
        return travelTime * holdTime
    }
}
