part of history_screen;

class OrderDisplay extends StatefulWidget {
  const OrderDisplay({super.key});

  @override
  State<OrderDisplay> createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: orderListCubit,
      builder: (context, state) {
        debugPrint("state $state");
        if (state is OrderListLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 0, 162, 255)),
          );
        } else if (state is OrderListLoaded) {
          debugPrint("masuk?");
          return state.data.data?.isEmpty == true
              ? Center(
                  child: Text("No Order"),
                )
              : ListView.builder(
                  itemCount: state.data.data?.length,
                  itemBuilder: (context, index) {
                    return ItemCardHistory(
                        orderId: state.data.data![index].orderId.toString(),
                        status: state.data.data![index].status,
                        subTitle: state.data.data![index].title,
                        title: state.data.data![index].serviceType,
                        totalPayment: state.data.data![index].totalPayment);
                  },
                );
        }
        return Center(
          child: Text("No Order"),
        );
      },
    );
  }
}
