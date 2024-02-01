part of pet_trainer;

class RecommendedTrainerFeed extends StatefulWidget {
  final List<Data.Datum> data;
  const RecommendedTrainerFeed({super.key, required this.data});

  @override
  State<RecommendedTrainerFeed> createState() => _RecommendedTrainerFeedState();
}

class _RecommendedTrainerFeedState extends State<RecommendedTrainerFeed> {
  final List<String> name = ["Dog", "Cat"];

  CurrencyFormarter currencyFormart = CurrencyFormarter();

  Widget trainerCard(Data.Datum data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => DetailTrainerScreen(
                      id: data.id.toString(),
                    ))));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 60.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0)
                    .withOpacity(0.5), // Shadow color with opacity
                spreadRadius: 0, // Spread radius
                blurRadius: 1, // Blur radius
                offset: const Offset(0, 0.5), // Offset from the top
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
                      child: Image.memory(
                        base64Decode(data.foto),
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
                          data.nama,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          data.pengalaman,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color.fromARGB(255, 181, 181, 181)),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color:
                                    const Color.fromARGB(255, 181, 181, 181))),
                        Text(
                            data.isAvailable == true
                                ? "Available"
                                : "Not Available",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: data.isAvailable == true
                                    ? Color.fromARGB(255, 0, 255, 21)
                                    : Colors.red)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(currencyFormart.currency(data.harga),
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 162, 255))),
                        Text("/Session",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color:
                                    const Color.fromARGB(255, 181, 181, 181))),
                      ],
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
    return SizedBox(
      height: 45.w,
      width: 100.w,
      child: ListView.builder(
        itemCount: widget.data.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return trainerCard(widget.data[index]);
        },
      ),
    );
  }
}
