import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  // name of the model file
  final _modelFile = 'text_classification.tflite';
  final _vocabFile = 'text_classification_vocab.txt';

  // Maximum length of sentence
  final int _sentenceLen = 256;

  Map<String, int> _dict={};

  // TensorFlow Lite Interpreter object
  Interpreter _interpreter;

  Classifier() {
    // Load model when the classifier is initialized.
    _loadModel();
    _loadDictionary();
  }

  void _loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    _interpreter = await Interpreter.fromAsset(_modelFile);
    print('Interpreter loaded successfully');
  }

  void _loadDictionary() async {
    final vocab = await rootBundle.loadString('assets/$_vocabFile');
    Map<String, int> dict = {};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }
    _dict = dict;
    print('Dictionary loaded successfully');
  }

  int classify(String rawText) {
    // tokenizeInputText returns List<List<double>>
    // of shape [1, 256].
    List<List<double>> input = tokenizeInputText(rawText.toLowerCase());
    List<List<double>> input1 = List<List<double>>.of(input, growable: false);

    // output of shape [1,2].
    // ignore: deprecated_member_use
    List<List<double>> output = List.generate(1, (i) => List.generate(2, (j) => 0.0, growable: false), growable: false);

    print('Input: $input1');
    print('Output: $output');
    _interpreter.run(input1, output);

    var result = 0;
    // If value of first element in output is greater than second,
    // then sentece is negative
    print('Result: $output');

    if (output[0][0] > output[0][1]) {
      print('Negative value assigned');
      result = 0;
    } else {
      print('Positive value assigned');
      result = 1;
    }
    print('Value returned..');
    return result;
  }

  List<List<double>> tokenizeInputText(String text) {
    // Whitespace tokenization
    final toks = text.split(' ');

    // Create a list of length==_sentenceLen filled with the value <pad>
    print(_dict);
    var vec = List<double>.filled(_sentenceLen, 0.0);

    var index = 0;
    if (_dict.containsKey('<START>')) {
      vec[index++] = 1.0;
    }

    // For each word in sentence find corresponding index in dict
    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      vec[index++] = _dict.containsKey(tok)
          ? _dict[tok].toDouble()
          : 2.0;
    }

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    return [vec];
  }
}