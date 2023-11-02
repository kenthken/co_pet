part of pet_trainer;

class RecommendedTrainerFeed extends StatefulWidget {
  const RecommendedTrainerFeed({super.key});

  @override
  State<RecommendedTrainerFeed> createState() => _RecommendedTrainerFeedState();
}

class _RecommendedTrainerFeedState extends State<RecommendedTrainerFeed> {
  final List<String> name = ["Dog", "Cat"];

  CurrencyFormarter currencyFormart = CurrencyFormarter();

  Widget specialize(String name) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 162, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          textAlign: TextAlign.center,
          name,
          style: TextStyle(color: Colors.white, fontSize: 10.sp),
        ),
      ),
    );
  }

  Widget trainerCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DetailTrainerScreen())));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0)
                    .withOpacity(0.5), // Shadow color with opacity
                spreadRadius: 0, // Spread radius
                blurRadius: 1, // Blur radius
                offset: Offset(0, 0.5), // Offset from the top
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      height: 15.w,
                      width: 15.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/petTrainer/person.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Michael Gowel",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          "10 Year Experience",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Color.fromARGB(255, 181, 181, 181)),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Specialize",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Color.fromARGB(255, 181, 181, 181))),
                        Container(
                            height: 8.w,
                            width: 80,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                name.length,
                                (index) {
                                  return specialize(name[index]);
                                },
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(currencyFormart.currency(50000),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 162, 255))),
                              Text("/Session",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color:
                                          Color.fromARGB(255, 181, 181, 181))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w,
      width: 100.w,
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return trainerCard();
        },
      ),
    );
  }
}
