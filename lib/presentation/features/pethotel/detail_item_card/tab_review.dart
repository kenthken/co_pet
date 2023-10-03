part of detail_item_card;

class TabReview extends StatefulWidget {
  const TabReview({super.key});

  @override
  State<TabReview> createState() => _TabReviewState();
}

class _TabReviewState extends State<TabReview> {
  Widget reviewCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 100.w,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 15.w,
                height: 15.w,
                color: Colors.grey,
                child: Image.network(
                  'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vincent Gowel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'NTR',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.33,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15.sp,
                      ),
                      Text(
                        "4.5/5",
                        style: TextStyle(
                            color: Color.fromARGB(255, 161, 161, 161),
                            fontSize: 13.sp),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam et tortor lectus. Maecenas sed facilisis libero, et dictum sem. Praesent volutpat ultrices est quis fringilla. Suspendisse id quam molestie, ',
              style: TextStyle(
                color: Color(0xFFBDBDBD),
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
            key: PageStorageKey<String>("Services"),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Rate ",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.sp,
                            ),
                            Text(
                              "4.5 (3)",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 161, 161, 161),
                                  fontSize: 15.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Reviews(3) ",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        reviewCard(),
                        reviewCard(),
                        reviewCard()
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
