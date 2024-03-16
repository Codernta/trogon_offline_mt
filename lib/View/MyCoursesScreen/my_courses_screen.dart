import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trogon_offline/Provider/my_courses_provider.dart';
import 'package:trogon_offline/Utilities/Styles/color_data.dart';
import 'package:trogon_offline/Utilities/Styles/text_styles.dart';
import 'package:trogon_offline/Utilities/Widgets/appbar_widget.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MyCoursePageProvider>(context, listen: false)
        .getCoursePageData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: appBars, body: courseBody());
  }

  courseBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            Consumer<MyCoursePageProvider>(builder: (context, provider, child) {
          return provider.loading
              ? loader()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    topCard(provider),
                    sizeBox(),
                    liveIcons(),
                    sizeBox(),
                    restItemsGrid(provider)
                  ],
                );
        }),
      ),
    );
  }

  sizeBox() {
    return const SizedBox(
      height: 50,
    );
  }

  topCard(MyCoursePageProvider provider) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        'Good Morning',
                        style: coursePageTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Text(
                        provider.myCoursePageModel!.data.userdata.name,
                        style: coursePageTitle,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Digital Marketing Certification',
                          style: homePageCardSubTitle,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff256EEE)),
                            onPressed: () {},
                            child: Text(
                              'Change',
                              style: coursePageButtonTitle,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 30,
          child: SizedBox(
            height: 80,
            child: Image.asset(
              'assets/images/icon1.png',
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  liveIcons() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue.shade100, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/icons/live_icon.png',
          ),
          Image.asset(
            'assets/icons/practice_icon.png',
          ),
          Image.asset(
            'assets/icons/exams_icon.png',
          ),
        ],
      ),
    );
  }

  restItemsGrid(MyCoursePageProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.myCoursePageModel!.data.subjects.length,
      itemBuilder: (context, index) {
        return gridItem(provider.myCoursePageModel!.data.subjects[index].icon,
            provider.myCoursePageModel!.data.subjects[index].title);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
    );
  }

  gridItem(String image, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.hardEdge,
            child:  CachedNetworkImage(
              height: 100,
              fit: BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) => const CircleAvatar(
                  radius:20,
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: homePageGridTitle,
          ),
        )
      ],
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
}
