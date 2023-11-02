part of history_screen;

class OrderDisplay extends StatefulWidget {
  const OrderDisplay({super.key});

  @override
  State<OrderDisplay> createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return ItemCardHistory(orderId: "123123123",status: "Waiting Payment",subTitle: "Jansen Petshop",title: "Pet Hotel",totalPayment: 50000);
      },
    );
  }
}
