enum Dynamic {
  piano('p'),
  pianoPiano('pp'),
  pianoPianoPiano('ppp'),
  mezzoPiano('mp'),
  forte('f'),
  forteForte('ff'),
  forteForteForte('fff'),
  mezzoForte('mf'),
  diminuendo('dim'),
  cresendo('cre'),
  sforzando('sfz');

  final String? value;
  const Dynamic(this.value);
}