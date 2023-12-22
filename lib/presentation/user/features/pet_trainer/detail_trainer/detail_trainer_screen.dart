library detail_trainer;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part "tab_review.dart";
part 'tab_services.dart';

class DetailTrainerScreen extends StatefulWidget {
  const DetailTrainerScreen({super.key});

  @override
  State<DetailTrainerScreen> createState() => _DetailTrainerScreenState();
}

class _DetailTrainerScreenState extends State<DetailTrainerScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Services', 'Review'];

    Widget backButton(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 0, 162, 255),
            ),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
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
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(0, 250, 250, 250)
                            ], // Define your gradient colors
                            stops: [0.15, 0.1],
                            begin: Alignment.bottomCenter, // Starting point
                            end: Alignment.topCenter, // Ending point
                          ).createShader(bounds);
                        },
                        blendMode:
                            BlendMode.srcATop, // Blend mode for the gradient
                        child: Image.asset(
                          "assets/petTrainer/person.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                        automaticIndicatorColorAdjustment: true,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 188, 188, 188),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: const Color.fromARGB(255, 0, 162, 255),
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
