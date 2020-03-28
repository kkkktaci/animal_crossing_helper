import 'package:animal_crossing_helper/models/animal.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

const int GOAL_INDEX = 4;
const int MOTTO_INDEX = 5;
const int FORIGN_NAME = 6;

Animal parseAnimalDetail(String html) {
  Document document = parse(html);
  Element infoBox = document.querySelector('div[class="box-poke-left"]');
  String goal = infoBox.children[GOAL_INDEX].children[1].text;
  String mottot = infoBox.children[MOTTO_INDEX].children[1].text;
  String forignName = infoBox.children[FORIGN_NAME].children[1].text;

  return Animal(goal: goal, motto: mottot, foreignWord: forignName);
}