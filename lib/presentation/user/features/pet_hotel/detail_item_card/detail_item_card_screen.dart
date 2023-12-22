library detail_item_card;

import 'package:co_pet/cubits/user/pet_hotel_grooming/store_detail_cubit.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart'
    as data;
import 'package:co_pet/presentation/user/features/pet_hotel/booking_pet_hotel_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

part "tab_review.dart";
part 'tab_services.dart';

class DetailItemCardScreen extends StatefulWidget {
  int id;
  DetailItemCardScreen({super.key, required this.id});

  @override
  State<DetailItemCardScreen> createState() => _DetailItemCardScreenState();
}

StoreDetailCubit storeDetailCubit = StoreDetailCubit();
data.Data? storeDetailModel;
bool storeDetailIsLoading = true;

class _DetailItemCardScreenState extends State<DetailItemCardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeDetailCubit.getStoreDetail(widget.id);
  }

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
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
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
                            blendMode: BlendMode
                                .srcATop, // Blend mode for the gradient
                            child: BlocBuilder(
                              bloc: storeDetailCubit,
                              builder: (context, state) {
                                if (state is StoreDetailLoaded) {
                                  storeDetailIsLoading = false;
                                }
                                return storeDetailIsLoading
                                    ? Shimmer.fromColors(
                                        baseColor:
                                            const Color.fromARGB(98, 184, 184, 184),
                                        highlightColor:
                                            const Color.fromARGB(255, 215, 215, 215),
                                        child: Image.asset(
                                          "assets/petHotel/toko.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        "assets/petHotel/toko.jpg",
                                        fit: BoxFit.cover,
                                      );
                              },
                            )),
                      ),
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                          automaticIndicatorColorAdjustment: true,
                          unselectedLabelColor:
                              const Color.fromARGB(255, 188, 188, 188),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: const Color.fromARGB(255, 0, 162, 255),
                          indicatorColor:
                              const Color.fromARGB(255, 72, 179, 255),
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
              body: BlocBuilder(
                  bloc: storeDetailCubit,
                  builder: (context, state) {
                    if (state is StoreDetailLoading) {
                      storeDetailIsLoading = true;
                    } else if (state is StoreDetailLoaded) {
                      debugPrint("skrtttt ");
                      storeDetailModel = state.data.data;
                      storeDetailIsLoading = false;
                    }
                    return const TabBarView(
                        children: [TabServices(), TabReview()]);
                  })),
        ));
  }
}
