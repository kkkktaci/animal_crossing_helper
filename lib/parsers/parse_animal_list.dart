import 'package:animal_crossing_helper/models/animal.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

final int INNER_NAME_INDEX = 1;
final int BIRTHDAY_INDEX = 4;
final int BYWORD_INDEX = 5;

List<Animal> parseAnimalList(String html) {
  List<Animal> result = List<Animal>();

  Document document = parse(html);
  Element table = document.querySelector('table[id="CardSelectTr"]');
  Element tbody = table.querySelector('tbody');
  List<Element> animalList = tbody.children;

  animalList.removeAt(0);
  try {
    animalList.forEach((item) {
      String image;
      try {
        Element img = item.getElementsByClassName('img-kk')[0];
        image = img.attributes['src'];
      } catch (e) {
        image = '';
      }
      String name = item.children[0].children[INNER_NAME_INDEX].text;
      String sex = item.attributes['data-param1'];
      String race = item.attributes['data-param2'];
      String nature = item.attributes['data-param3'];
      String birthday = item.children[BIRTHDAY_INDEX].text;
      String byword = item.children[BYWORD_INDEX].text;

      result.add(Animal(name: name, image: image, sex: sex, race: race, nature: nature, birthday: birthday, byword: byword));
    });
  } catch (e) {
    print('Error! ${e.toString()}');
  }

  return result;
}