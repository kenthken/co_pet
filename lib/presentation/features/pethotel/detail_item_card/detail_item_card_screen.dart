import 'package:co_pet/presentation/features/pethotel/detail_item_card/detail_item_card_scree.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailItemCardScreen extends StatelessWidget {
  const DetailItemCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Jansen Petshop";
    final List<String> tabs = <String>['Services', 'Review'];
    Widget backButton(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 0, 162, 255),
            ),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ))),
      );
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    centerTitle: true,
                    leading: backButton(context),
                    expandedHeight: 30.h,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 84, 84, 84),
                              Color.fromARGB(0, 250, 250, 250)
                            ], // Define your gradient colors
                            stops: [0, 0.5],
                            begin: Alignment.bottomCenter, // Starting point
                            end: Alignment.topCenter, // Ending point
                          ).createShader(bounds);
                        },
                        blendMode:
                            BlendMode.srcATop, // Blend mode for the gradient
                        child: Image.asset(
                          "assets/petHotel/toko.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                        automaticIndicatorColorAdjustment: true,
                        unselectedLabelColor:
                            Color.fromARGB(255, 188, 188, 188),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Color.fromARGB(255, 0, 162, 255),
                        indicatorColor: const Color.fromARGB(255, 72, 179, 255),
                        onTap: ((value) {}),
                        labelStyle: SizerUtil.deviceType == DeviceType.mobile
                            ? TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold)
                            : TextStyle(
                                fontSize: 9.sp, fontWeight: FontWeight.bold),
                        tabs: tabs
                            .map((String name) => Tab(text: name))
                            .toList()),
                  ),
                ),
              ];
            },
            body: const TabBarView(children: [TabServices(), TabReview()]),
          ),
        ));
  }
}
