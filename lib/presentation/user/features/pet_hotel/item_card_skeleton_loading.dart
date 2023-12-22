part of pet_hotel;

class ItemCardSkeleton extends StatefulWidget {
  const ItemCardSkeleton({
    super.key,
  });

  @override
  State<ItemCardSkeleton> createState() => _ItemCardSkeletonState();
}

class _ItemCardSkeletonState extends State<ItemCardSkeleton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(98, 184, 184, 184),
                    highlightColor: const Color.fromARGB(255, 215, 215, 215),
                    child: Image.asset(
                      "assets/petHotel/toko.jpg",
                      fit: BoxFit.cover,
                      height: 15.h,
                      width: 100.w,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                              baseColor: const Color.fromARGB(98, 184, 184, 184),
                              highlightColor:
                                  const Color.fromARGB(255, 215, 215, 215),
                              child: Container(
                                color: Colors.white,
                                height: 5.w,
                                width: 30.w,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Shimmer.fromColors(
                                      baseColor:
                                          const Color.fromARGB(98, 184, 184, 184),
                                      highlightColor:
                                          const Color.fromARGB(255, 215, 215, 215),
                                      child: Container(
                                        color: Colors.white,
                                        height: 5.w,
                                        width: 5.w,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor:
                                          const Color.fromARGB(98, 184, 184, 184),
                                      highlightColor:
                                          const Color.fromARGB(255, 215, 215, 215),
                                      child: Container(
                                        color: Colors.white,
                                        height: 5.w,
                                        width: 7.w,
                                      )),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
