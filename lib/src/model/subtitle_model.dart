class SubtitleModel {
  int? index;
  int? timeBegin;
  int? timeEnd;
  String? subtitleString;
  SubtitleModel({
    this.index,
    this.timeBegin,
    this.subtitleString,
    this.timeEnd,
  });

  factory SubtitleModel.fromString(String webVttString) {
    Duration _parseDuration(String s) {
      int hours = 0;
      int minutes = 0;
      int micros;
      List<String> parts = s.split(':');
      if (parts.length > 2) {
        hours = int.parse(parts[parts.length - 3]);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[parts.length - 2]);
      }
      micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    }

    int _returnsMinimumTime(
      String webvttString,
    ) {
      var splitByBR = webvttString.split('\n');
      return _parseDuration(splitByBR[1].split('-->')[0].trim()).inMilliseconds;
    }

    int _returnsMaximumTime(
      String webvttString,
    ) {
      var splitByBR = webvttString.split('\n');
      _parseDuration(splitByBR[1].split('-->')[1].trim()).inMilliseconds;
      return _parseDuration(splitByBR[1].split('-->')[1].trim()).inMilliseconds;
    }

    return SubtitleModel(
      timeBegin: _returnsMinimumTime(webVttString),
      timeEnd: _returnsMaximumTime(webVttString),
      index: int.tryParse(
        webVttString.split("\n")[0],
      ),
      subtitleString: webVttString.split("\n").skip(2).join("\n"),
    );
  }
}
