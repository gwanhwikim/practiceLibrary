import 'package:carousel/model/imageModel.dart';
import 'package:carousel/store/imageStore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<ImageModel> item = [
    ImageModel(id: 1, title: "애니", imageUrl: "1.jpg"),
    ImageModel(id: 2, title: "별 + 산", imageUrl: "2.jpg"),
    ImageModel(id: 3, title: "하늘", imageUrl: "3.png"),
    ImageModel(id: 4, title: "구름", imageUrl: "4.jpg"),
    ImageModel(id: 5, title: "캐릭터", imageUrl: "5.png"),
  ];

  final CarouselController controller = CarouselController();

  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캐러셀'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 0.8,
                    initialPage: dotIndex,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged:
                        (index, CarouselPageChangedReason changeReason) {
                      setState(() {
                        dotIndex = index;
                      });
                    }, //저 reason이 뭐지
                  ),
                  carouselController: controller,
                  items: item.map((i) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          color: Colors.blue,
                          child: Image.asset(
                            'assets/${i.imageUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    });
                  }).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(item.length, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: dotIndex == index
                        ? Icon(Icons.circle)
                        : Icon(Icons.circle_outlined),
                  );
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => controller.previousPage(),
                  child: Text('이전페이지'),
                ),
                TextButton(
                  onPressed: () => controller.nextPage(),
                  child: Text('다음페이지'),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    item.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          controller.animateToPage(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
