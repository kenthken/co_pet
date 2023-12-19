part of detail_item_card;

class TabReview extends StatefulWidget {
  const TabReview({super.key});

  @override
  State<TabReview> createState() => _TabReviewState();
}

class _TabReviewState extends State<TabReview> {
  Widget reviewCard(data.Review reviewData) {
    int rate = int.parse(reviewData.rate);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reviewData.namaUser,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontFamily: 'NTR',
                  fontWeight: FontWeight.bold,
                  height: 0,
                  letterSpacing: 0.33,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: rate.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemSize: 20,
                    allowHalfRating: false,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              reviewData.reviewDescription,
              style: TextStyle(
                color: const Color.fromARGB(255, 83, 81, 81),
                fontSize: 10.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 0.33,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: const PageStorageKey<String>("Services"),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reviews (${storeDetailModel!.totalRating}) ",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                        for (data.Review e in storeDetailModel!.review)
                          reviewCard(e),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
