part of check_out;

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

Widget paymentList(Image image, String title) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Color.fromARGB(142, 215, 215, 215),
          width: 2.0,
        ),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(5.w),
      child: Row(
        children: [
          Container(
            width: 20, // Set the width and height to make it circular
            height: 20,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue, // Border color
                width: 2.0, // Border width
              ),
            ),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
              width: 20.w,
              height: 10.w,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: image),
          Text(
            title,
            style: TextStyle(fontSize: 10.sp),
          )
        ],
      ),
    ),
  );
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          paymentList(
              Image.asset(
                "assets/checkOut/bca.png",
                fit: BoxFit.contain,
              ),
              "BCA Virtual Account")
        ],
      ),
    );
  }
}
