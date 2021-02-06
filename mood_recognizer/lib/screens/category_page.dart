import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  bool category;
  CategoryPage({this.category});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> imagesA = [
    'images/animals/pic1.gif',
    'images/animals/pic2.gif',
    'images/animals/pic3.gif',
    'images/animals/pic4.gif',
    'images/animals/pic5.gif',
  ];

  List<String> imagesB = [
    'images/baby/pic1.gif',
    'images/baby/pic2.gif',
    'images/baby/pic3.gif',
    'images/baby/pic4.gif',
    'images/baby/pic5.gif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (widget.category == true)
                        ? 'Cute Baby Pics'
                        : 'Cute Animal Pics',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int itemIndex, _) {
                    return CarouselItems(
                      image: (widget.category == true)
                          ? imagesB[itemIndex]
                          : imagesA[itemIndex],
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlay: false,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CarouselItems extends StatelessWidget {
  CarouselItems({
    @required this.image,
  });
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.yellow[900], width: 4.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
