enum Duration {
  whole(1.0),
  half(0.5),
  quarter(0.25),
  eighth(0.125),
  sixteenth(0.0625),
  thirtySecond(0.03125),
  sixtyFourth(0.015625);

  final double value;
  const Duration(this.value);
}
