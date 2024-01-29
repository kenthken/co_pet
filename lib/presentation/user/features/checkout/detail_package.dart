part of check_out;

class DetailPackage extends StatelessWidget {
  final CheckoutModel checkoutModel;
  DetailPackage({super.key, required this.checkoutModel});

  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

  Widget itemList(String itemName, int quantity, int itemPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
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

  Widget additionalCharge(String itemName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 10.sp),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Text(
          "Free",
          style: TextStyle(fontSize: 10.sp, color: Colors.green),
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
              checkoutModel.title,
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
                        color: const Color.fromARGB(255, 159, 159, 159),
                        fontSize: 12.sp),
                  ),
                  Text(checkoutModel.detailPackage,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 159, 159, 159),
                          fontSize: 12.sp)),
                  const SizedBox(
                    height: 10,
                  ),
                  for (var e in checkoutModel.listPackage!)
                    itemList(e.packageName, e.quantity, e.price),
                  additionalCharge("Administration"),
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
                  currencyFormatter.format(checkoutModel.total),
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
