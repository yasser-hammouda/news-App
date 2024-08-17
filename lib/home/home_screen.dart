import 'package:flutter/material.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home/category/category_details.dart';
import 'package:news_app/home/category/category_fragment.dart';
import 'package:news_app/home/home_drawer.dart';
import 'package:news_app/home/setting/setting_tab.dart';
import 'package:news_app/model/category.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category? selectedCategory;
  int selectedSideMenuItem = HomeDrawer.categories;
  bool isSearching = false;

  TextEditingController searchController = TextEditingController();

  void onCategoryItemClick(Category newCategory) {
    selectedCategory = newCategory;
    setState(() {});
  }

  void onSideMenuItemClick(int newSideMenuItem) {
    selectedSideMenuItem = newSideMenuItem;
    selectedCategory = null; // reset selected category
    Navigator.pop(context);
    setState(() {});
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: isSearching
                ? TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            )
                : Text(
              selectedSideMenuItem == HomeDrawer.settings
                  ? 'Settings'
                  : selectedCategory == null
                  ? 'News App'
                  : selectedCategory!.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              if (selectedSideMenuItem != HomeDrawer.settings)
                IconButton(
                  icon: Icon(isSearching ? Icons.close : Icons.search),
                  onPressed: toggleSearch,
                ),
            ],
          ),
          drawer: Drawer(
            child: HomeDrawer(onSideMenuItemClick: onSideMenuItemClick),
          ),
          body: selectedSideMenuItem == HomeDrawer.settings
              ? SettingTab()
              : selectedCategory == null
              ? CategoryFragment(onCategoryItemClick: onCategoryItemClick)
              : CategoryDetails(
            category: selectedCategory!,
            searchQuery: searchController.text,
          ),
        ),
      ],
    );
  }
}
