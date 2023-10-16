part of check_out;

class DetailPackage extends StatelessWidget {
  final String tenantName;
  final String detailPackageDescription;
  final int totalPrice;

  DetailPackage(
      {super.key,
      required this.tenantName,
      required this.detailPackageDescription,
      required this.totalPrice});

  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

  Widget itemList(String itemName, int quantity, int itemPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 10.sp),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${quantity.toString()}x",
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
          ),
        ),
        Text(
          currencyFormatter.format(itemPrice),
          style: TextStyle(fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget detailPackage() {
    return Container(
      color: Colors.white,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tenantName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        width: 1, color: Color.fromARGB(255, 217, 217, 217)))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Package",
                    style: TextStyle(
                        color: Color.fromARGB(255, 159, 159, 159),
                        fontSize: 12.sp),
                  ),
                  Text(detailPackageDescription,
                      style: TextStyle(
                          color: Color.fromARGB(255, 159, 159, 159),
                          fontSize: 12.sp)),
                  const SizedBox(
                    height: 10,
                  ),
                  itemList("Administration", 1, 1000)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Text(
                  currencyFormatter.format(totalPrice),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return detailPackage();
  }
}
