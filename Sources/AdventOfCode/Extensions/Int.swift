extension String {
    var lastIndex: Index {
        index(before: endIndex)
    }
}
