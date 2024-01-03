part of history_screen;

class ItemCardHistory extends StatelessWidget {
  final bool isPetService;
  final String title;
  final String subTitle;
  final String orderId;
  final String status;
  final int totalPayment;
  ItemCardHistory(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.orderId,
      required this.status,
      required this.totalPayment,
      required this.isPetService});

  CurrencyFormarter currencyformat = CurrencyFormarter();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: isPetService
            ? OrderDetailPetServiceScreen(orderId: orderId)
            : PaymentScreen(
                orderId: orderId,
              ),
        withNavBar: false,
      ),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 178, 178, 178),
                              fontSize: 10.sp),
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 178, 178, 178),
                              fontSize: 10.sp),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.sp),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 178, 178, 178),
                              fontSize: 10.sp),
                        ),
                        Text(
                          orderId,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 178, 178, 178),
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currencyformat.currency(totalPayment),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 162, 255),
                              fontSize: 13.sp),
                        ),
                        Text(
                          "Total Payment",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 178, 178, 178),
                              fontSize: 10.sp),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
