import 'dart:math';

String generateDisplayOrder(int orderPosition) {
  const russianLetters = 'АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯ';
  final random = Random();

  final letter = russianLetters[random.nextInt(russianLetters.length)];
  final numberPart = orderPosition.toString().padLeft(2, '0'); 

  return '$letter$numberPart';
}
