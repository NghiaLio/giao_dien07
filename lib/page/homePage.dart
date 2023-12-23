import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final _controller = PageController(
      viewportFraction: 0.7
    );

  // void _listener(){
  //   setState(() {
  //     _currentPage = _controller.page!.toInt();
  //     // _index = _currentPage.toInt();
  //   });
  // }
  
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller.addListener(_listener);
  // }
 
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controller.removeListener(_listener);
  // }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "PageView",
          style: TextStyle(fontSize: 30),
        ),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height*2/5,
            child: PageView.builder(
              controller: _controller,
              itemCount: data.length,
              onPageChanged: (int index){
                setState(() {
                  _currentPage = index;
                });
                if(_currentPage == data.length){
                  _controller.animateToPage(0, duration:const Duration(milliseconds: 500), curve: Curves.easeInBack);
                }
              },
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 100,
                decoration: BoxDecoration(
                  color: data[index].color,
                  borderRadius:const BorderRadius.all(Radius.circular(20))
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  child: Text(data[index].name),
                )
              )
            ),
          ),
          SmoothPageIndicator(
            controller: _controller, 
            count: data.length,
            effect:ExpandingDotsEffect(
              dotHeight: 15,
              dotWidth: 15,
              activeDotColor: data[_currentPage].color,
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: (){
              if(_currentPage == data.length-1){
                // _controller.jumpToPage(0);
                _controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInSine);
              }else{
              _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInSine);
              }
            },
            style:ButtonStyle(
              // maximumSize: MaterialStatePropertyAll(),
              backgroundColor: MaterialStatePropertyAll(data[_currentPage].color),
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              )
            ), 
            child:const Icon(Icons.navigate_next_outlined, size: 40,),
          )
        ],
      ),
    );
  }
}