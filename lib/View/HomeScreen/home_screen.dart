import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:scroll_page_view/scroll_page.dart';
import 'package:trogon_offline/Provider/home_page_provider.dart';
import 'package:trogon_offline/Utilities/Styles/color_data.dart';
import 'package:trogon_offline/Utilities/Styles/text_styles.dart';
import 'package:trogon_offline/View/Dashboard/dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _images = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? userImage = '';
  String? userName = '';

  @override
  void initState() {
    super.initState();
    Provider.of<HomePageProvider>(context, listen: false)
        .getHomePageData(context: context)
        .then((value) => loadImageData())
        .then((value) => loadUserData());
  }

  void loadImageData() {
    Provider.of<HomePageProvider>(context, listen: false)
        .homePageModel!
        .data
        .adBanner
        .asMap()
        .forEach((key, child) {
      String imageValue = child.image;
      _images.add(imageValue);
    });
  }

  void loadUserData() {
    setState(() {
      userImage = Provider.of<HomePageProvider>(context, listen: false)
          .homePageModel!
          .data
          .userdata
          .image;
      userName = Provider.of<HomePageProvider>(context, listen: false)
          .homePageModel!
          .data
          .userdata
          .name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawer(),
      backgroundColor: primaryColor,
      appBar: appBar(),
      body: homeBody(),
    );
  }

  homeBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<HomePageProvider>(builder: (context, provider, child) {
          return provider.loading
              ? loader()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    customSlider(provider),
                    sizeBox(),
                    gridItems(provider),
                    sizeBox(),
                    bottomCard()
                  ],
                );
        }),
      ),
    );
  }

  sizeBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _imageView(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) => const CircleAvatar(
              radius: 20, child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  gridItem(String image, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) => const Center(
              child:
                  CircleAvatar(radius: 20, child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: homePageGridTitle,
        )
      ],
    );
  }

  bottomCard() {
    return SizedBox(
      height: 150,
      width: 300,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 1, color: Color(0xffDB4B5E))),
              child: Transform(
                transform: Matrix4.translationValues(30, 0, 0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore',
                            style: homePageCardSubTitle,
                          ),
                          Text(
                            'Monthly Current \nAffairs',
                            style: homePageCardTitle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.yellow.shade600,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            left: 20,
            child: Image.asset(
              'assets/images/images1.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  loader() {
    return Center(
      child: CircleAvatar(
          radius: 20,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircularProgressIndicator(
              color: Colors.blue.shade900,
            ),
          )),
    );
  }

  gridItems(HomePageProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.homePageModel!.data.topCourses.length,
      itemBuilder: (context, index) {
        return gridItem(
            provider.homePageModel!.data.topCourses[index].thumbnail,
            provider.homePageModel!.data.topCourses[index].title);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 0.0),
    );
  }

  customSlider(HomePageProvider provider) {
    return SizedBox(
      height: 164,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 164,
              child: ScrollPageView(
                controller: ScrollPageController(),
                delay: const Duration(seconds: 3),
                indicatorAlign: Alignment.bottomCenter,
                children: (_images.reversed)
                    .map((image) => _imageView(image))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: SvgPicture.asset(
              'assets/icons/appbar_menu_icon.svg',
              height: 50,
            )),
      ),
      actions: [
        IconButton(
            onPressed: () => Get.to(() => DashBoard(index: 2)),
            icon:
                SvgPicture.asset('assets/icons/appbar_notification_icon.svg')),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  sideDrawer() {
    return Drawer(
        child: ListView(
      children: [drawerHeader()],
    ));
  }

  drawerHeader() {
    return SizedBox(
      height: 200,
      child: DrawerHeader(
        child: Column(
          children: [profilePic(), userNames()],
        ),
      ),
    );
  }

  profilePic() {
    return CircleAvatar(
      radius: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: userImage.toString(),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  userNames() {
    return Text(userName.toString());
  }
}
