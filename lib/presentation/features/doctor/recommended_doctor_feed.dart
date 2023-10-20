part of pet_doctor;

class RecommendedDoctorFeed extends StatefulWidget {
  const RecommendedDoctorFeed({super.key});

  @override
  State<RecommendedDoctorFeed> createState() => _RecommendedDoctorFeedState();
}

class _RecommendedDoctorFeedState extends State<RecommendedDoctorFeed> {
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

  Widget doctorCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DetailDoctorScreen())));
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
                        color: Colors.amber,
                      ),
                      child: Image.asset(
                        "assets/petDoctor/doctor.jpg",
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
                          "Dr Michael Gowel",
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              vertical: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 217, 217, 217)))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("No STR",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Color.fromARGB(255, 181, 181, 181))),
                            Text("1212121212121",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Color.fromARGB(255, 181, 181, 181),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Color.fromARGB(255, 181, 181, 181))),
                          Text(currencyFormart.currency(50000),
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold)),
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
          return doctorCard();
        },
      ),
    );
  }
}
