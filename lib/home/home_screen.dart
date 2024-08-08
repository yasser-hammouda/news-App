import 'package:flutter/material.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home/tabs/tab_widget.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/model/api_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName ='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset('assets/images/main_background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('News App', style: Theme.of(context).textTheme.titleLarge,),
          ),
          body: FutureBuilder<SourceResponse?>(
              future: ApiManager.getSources(),
              builder: (context,snapShot) {
                if(snapShot.connectionState == ConnectionState.waiting){
                  return Center( child: CircularProgressIndicator(
                    color: AppColors.primaryLightColor,
                  ),);
                }
                else if (snapShot.hasError){   // error from my side
                  return Column(
                    children: [
                      Text('Something went wrong!!'),
                      ElevatedButton(
                          onPressed: (){},
                          child: Text('Try Again..'))
                    ],
                  );
                }
                // check if snapShot.data is null
                if (snapShot.data == null){
                  return Column(
                    children: [
                      Text('No data available!'),
                      ElevatedButton(
                          onPressed: (){
                            ApiManager.getSources();
                            setState(() {});
                          },
                          child: Text('Try Again..'))
                    ],
                  );
                }
                //server has reply with response => success or fail
                if(snapShot.data!.status != 'ok'){
                  return Column(
                    children: [
                      Text(snapShot.data!.message! ?? 'Unknown error'),
                      ElevatedButton(
                          onPressed: (){
                            ApiManager.getSources();
                            setState(() {});
                          },
                          child: Text('Try Again..'))
                    ],
                  );
                }
                // I'm sure I have success response
                var sourceList =snapShot.data!.sources!;
                return TabWidget(sourcesList: sourceList,);
                // return ListView.builder(itemBuilder: (context,index){
                //   return Text(sourceList[index].name?? " ");
                // },itemCount: sourceList.length,
                // );
              }
          ),
        ),
      ],
    );
  }
}
