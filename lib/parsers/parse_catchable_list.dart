import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

final int INNER_NAME_INDEX = 1;
final int IAMGE_INDEX = 0;
final int PLACE_INDEX = 1;
final int EXTRA_INDEX = 2;
final int NORTH_INDEX = 3;
final int SOUTH_INDEX = 4;
final int TIME_INDEX = 5;
final int PRICE_INDEX = 6;

List<Catchable> parseCatchableList(String html, TYPE type) {
  List<Catchable> result = List<Catchable>();

  Document document = parse(html);
  Element table = document.querySelector('table[id="CardSelectTr"]');
  Element tbody = table.querySelector('tbody');
  List<Element> fishList = tbody.children;
  fishList.removeAt(0);
  try {
    fishList.forEach((item) {
      String image;
      try {
        Element img = item.getElementsByClassName('img-kk')[0];
        image = img.attributes['src'];
      } catch (e) {
        image = '';
      }
      String name = item.children[0].children[INNER_NAME_INDEX].text;
      String place = item.attributes['data-param1'];
      // 鱼影或者昆虫出现天气
      String extra = item.attributes['data-param2'];
      List<String> north = item.attributes['data-param3'].split(", ");
      List<String> south = item.attributes['data-param4'].split(", ");
      List<String> time = item.attributes['data-param5'].split(", ");
      String price = item.children[PRICE_INDEX].text;

      result.add(Catchable(
        name: name,
        image: image,
        price: price,
        south: south,
        north: north,
        time: time,
        activePlace: place,
        extra: extra,
        type: type
      ));
    });
  } catch (e) {
    print('Error! ${e.toString()}');
  }

  return result;
}