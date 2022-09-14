import 'package:flutter/material.dart';
import 'package:shopping_app/Modules/login/login_screen.dart';
import 'package:shopping_app/components/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/components/constance.dart';
import 'package:shopping_app/shared/remote/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
var boardController = PageController();
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image:'assets/images/image2.jpg',
        title: 'Title Screen 1',
        body: 'Body Screen 1'),
    BoardingModel(
        image:'assets/images/image3.jpg',
        title: 'Title Screen 2',
        body: 'Body Screen 2'),
    BoardingModel(
        image:'assets/images/image1.jpg',
        title: 'Title Screen 3',
        body: 'Body Screen 3'),
  ];

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'SKIP',
            function: (){
              submit();
            }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildOnBoardin(boarding[index]),
                itemCount: boarding.length,
                  onPageChanged: (int index){
                    if(index == boarding.length - 1){
                      setState(() {
                        isLast = true;
                      });
                    }else{
                      isLast = false;
                    }
                  },
                ),
              ),

              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 4
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        setState(() {
                       submit();
                        });
                      }else{
                        boardController.nextPage(
                            duration: Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },

                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget buildOnBoardin(BoardingModel model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image:
              AssetImage(
                  '${model.image}'
              ),
              fit: BoxFit.cover
          ),
        ),
      ),
      SizedBox(
        height: 70,
      ),
      Text(
        '${model.title}',
        style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30),
      ),

      Text(
        '${model.body}',
        style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold,fontSize: 30),
      ),

    ],
  );
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }
}
