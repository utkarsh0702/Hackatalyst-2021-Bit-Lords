String lookUp(int number){
  String image;
  var map={
    0:'images/funny1.gif',
    2:'images/funny2.gif',
    3:'images/funny3.gif',
    4:'images/funny4.gif',
    1:'images/funny5.gif'
  };
  image = map[number];
  return image;
}

String urlLook(int number){
  String image;
  var map={
    0:'https://www.youtube.com/watch?v=2bbkHIHzH28',
    1:'https://www.youtube.com/watch?v=flND0iO2Qa8',
    2:'https://www.youtube.com/watch?v=X7R-q9rsrtU',
    3:'https://www.youtube.com/watch?v=H4PAKzzThUk',
    4:'https://www.youtube.com/watch?v=Qoe63392oM0',
    5:'https://www.youtube.com/watch?v=8RZfZ3qpAMk',
    6:'https://www.youtube.com/watch?v=L49VXZwfup8',
    7:'https://www.youtube.com/watch?v=4tk83EJHkwU',
    8:'https://www.youtube.com/watch?v=MwE4PGSgQW8',
    9:'https://www.youtube.com/watch?v=fkorWPoi6E0',
    10:'https://www.youtube.com/watch?v=BgOMRTof69w',
  };
  image = map[number];
  return image;
}