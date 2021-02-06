import 'package:flutter/material.dart';

import 'category_page.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
                  child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Categories',
                        style: TextStyle(
                            fontFamily: 'Langar',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor
                        ),
                      ),
                  ],
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: ListView(
                   children: [
                     CategoriesLayout(imageUrl: 'images/baby/back.jpg',categoryName: 'Cute Baby Pics', category: true,),
                     CategoriesLayout(imageUrl: 'images/animals/back.jpg',categoryName: 'Cute Animal Pics', category: false,),
                   ],
            ),
                ),
            ],
          ),
        ) 
      );
  }
}

//-------------------- Category Class ---------------------------//
// ignore: must_be_immutable
class CategoriesLayout extends StatelessWidget {

  final String imageUrl;
  final String categoryName;
  bool category;

  CategoriesLayout({ this.imageUrl,this.categoryName, this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryPage(
            category: category,
          )
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right : 20.0, left : 20.0),
        child: Container(
            margin: EdgeInsets.only(top: 15,bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: Offset(2,2)
                        )],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black45,
                  ),
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
