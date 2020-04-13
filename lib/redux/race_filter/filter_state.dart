class RaceFilterState {
  String selected;
  RaceFilterState({this.selected});

  factory RaceFilterState.initial() =>
    RaceFilterState(selected: null);

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is RaceFilterState &&
      runtimeType == other.runtimeType &&
      selected == other.selected;

  @override
  int get hashCode => selected.hashCode;

  @override
  String toString() {
    return 'RaceFilterState{selected: $selected}';
  }
}