// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';
import 'package:subtitle_view/src/model/subtitle_model.dart';

class SubtitleController {
  String subtitleUrl;
  SubtitleController({
    required this.subtitleUrl,
  }) {
    _readSubtitleWebVtt(subtitleUrl);
  }
  List<SubtitleModel>? _subtitleDataList = <SubtitleModel>[];
  List<String>? _subtitleStringList = <String>[];

  List<SubtitleModel> get subtitleDataList => _subtitleDataList ?? [];
  List<String> get subtitleStringList => _subtitleStringList ?? [];

  Future<void> _readSubtitleWebVtt(String url) async {
    if (url != "") {
      Dio dio = Dio();
      try {
        var response = await dio.get(
          url,
        );
        if (response.statusCode == 200) {
          _subtitleStringList =
              _jsonToSubtitleAsListString(response.data.toString());
          _convertSubtitleListToSubtitleMap();
        } else {
          _subtitleStringList = [];
        }
      } on DioError catch (e) {
        throw Exception(e);
      }
    }
  }

  List<String> _jsonToSubtitleAsListString(String data) {
    var regex = RegExp(
      r'(\d+)?\n(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)\s?-->\s?(\d{1,}:)?(\d{1,2}:)?(\d{1,2}).(\d+)(.*(?:\r?(?!\r?).*)*)\n(.*(?:\r?\n(?!\r?\n).*)*)',
    );
    Iterable<String> _allStringMatches(String text, RegExp regExp) =>
        regExp.allMatches(text).map((m) => m.group(0) ?? "");
    if (data != '') {
      var regexed = _allStringMatches(data, regex);
      return regexed.toList();
    }
    return <String>[];
  }

  void _convertSubtitleListToSubtitleMap() {
    for (var subtitleIndex = 0;
        subtitleIndex < (_subtitleStringList?.length ?? 0);
        subtitleIndex++) {
      _subtitleDataList?.add(
        SubtitleModel.fromString(
          _subtitleStringList![subtitleIndex],
        ),
      );
    }
  }

  String textFromWebttvBasedOnMilliseconds(
      int currentTimeMilliseconds, List<SubtitleModel>? subtitleDataList) {
    SubtitleModel? subtitleDataModel;
    try {
      subtitleDataModel = subtitleDataList?.lastWhere((data) =>
          currentTimeMilliseconds >= (data.timeBegin ?? -1) &&
          currentTimeMilliseconds <= (data.timeEnd ?? -1));
    } catch (_) {}
    return subtitleDataModel?.subtitleString ?? "";
  }
}
