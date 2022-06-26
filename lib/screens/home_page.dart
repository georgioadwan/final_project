//import 'package:final_project/constants.dart';
import 'package:final_project/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
          onPageChanged: (num){
                setState ((){
                  _selectedTab = num;
                });
          },
          children: [
          Container (
          child: Center(
          child: Text("Homepage"),
             ),
           ),
            Container (
              child: Center(
                child: Text("Search Page"),
              ),
            ),
            Container (
              child: Center(
                child: Text("Saved Page"),
              ),
            ),
        ],
          ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState ((){
                _tabsPageController.animateToPage(num,
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeOutCubic);
              });
            },
          ),
        ],
        )
      );
  }
}
