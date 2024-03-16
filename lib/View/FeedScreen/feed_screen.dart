import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trogon_offline/Provider/feed_page_provider.dart';
import 'package:trogon_offline/Utilities/Styles/color_data.dart';
import 'package:trogon_offline/Utilities/Styles/text_styles.dart';
import 'package:trogon_offline/Utilities/Widgets/appbar_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool unlike = false;
  bool isBookMarked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FeedPageProvider>(context, listen: false)
        .getFeedPageData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBars,
      body: feedBody(),
    );
  }

  feedBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<FeedPageProvider>(builder: (context, provider, child) {
        return provider.loading
            ? loader()
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height,
                width: size.width,
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return divider();
                    },
                    itemCount: provider.feedPageModel!.data.length,
                    itemBuilder: (context, index) {
                      return feedItem(provider, index);
                    }),
              );
      }),
    );
  }

  feedItem(FeedPageProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizeBox(),
          feedTitleImage(provider, index),
          sizeBox(),
          feedLiskeRow(provider, index),
          sizeBox(),
          feedCategory(provider, index),
          sizeBox(),
          feedTitle(provider, index),
          sizeBox(),
          feedContent(provider, index)
        ],
      ),
    );
  }

  sizeBox() {
    return const SizedBox(
      height: 10,
    );
  }

  feedTitleImage(FeedPageProvider provider, int index) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        height: 220,
        width: size.width * 0.9,
        imageUrl: provider.feedPageModel!.data[index].file,
        placeholder: (context, url) => const Center(
          child: CircleAvatar(radius: 20, child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  feedLiskeRow(FeedPageProvider provider, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [likeAndCount(provider, index), whatsappAndSave()],
    );
  }

  likeAndCount(FeedPageProvider provider, int index) {
    // bool unlike = Provider.of<FeedPageProvider>(context,listen: false).feedPageModel!.data[index].isLiked == 1
    //   ? true
    //   : false;
    return SizedBox(
        width: 120,
        child: Row(
          children: [
            IconButton(
              onPressed: () => setState(() {
                unlike = !unlike;
              }),
              icon: unlike
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
            ),
            Text(provider.feedPageModel!.data[index].likeCount.toString() +
                ' Likes')
          ],
        ));
  }

  whatsappAndSave() {
    return SizedBox(
      width: 80,
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Colors.green,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: isBookMarked
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border),
            onPressed: () => setState(() {
              isBookMarked = !isBookMarked;
            }),
          )
        ],
      ),
    );
  }

  feedTitle(FeedPageProvider provider, int index) {
    return Text(
      provider.feedPageModel!.data[index].title,
      style: homePageTitle,
    );
  }

  feedContent(FeedPageProvider provider, int index) {
    // return Text(provider.feedPageModel!.data[index].content,style: homePageCardSubTitle,);
    return Html(data: provider.feedPageModel!.data[index].content);
  }

  loader() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: CircleAvatar(
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircularProgressIndicator(
                color: Colors.blue.shade900,
              ),
            )),
      ),
    );
  }

  feedCategory(FeedPageProvider provider, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          provider.feedPageModel!.data[index].category.toString(),
          style: feedCategoryStyle,
        ),
        Text(
          provider.feedPageModel!.data[index].date,
          style: feedDateStyle,
        ),
      ],
    );
  }

  divider() {
    return const Divider(
      height: 2,
      color: Colors.grey,
    );
  }
}
