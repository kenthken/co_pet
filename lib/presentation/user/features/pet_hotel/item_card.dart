part of pet_hotel;

class ItemCard extends StatefulWidget {
  int id;
  String title;
  String rating;
  dynamic foto;
  String totalRating;
  String isOpen;
  ItemCard(
      {super.key,
      required this.id,
      required this.title,
      required this.foto,
      required this.rating,
      required this.totalRating,
      required this.isOpen});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailItemCardScreen(id: widget.id.toString())));
      },
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
                  Image.memory(
                    base64Decode(widget.foto),
                    height: 15.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    "${widget.rating} (${widget.totalRating})",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 161, 161, 161),
                                        fontSize: 10.sp),
                                  )
                                ],
                              ),
                              Text(widget.isOpen == "true" ? "Open" : "Closed",
                                  style: TextStyle(
                                      color: widget.isOpen == "true"
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 10.sp))
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
