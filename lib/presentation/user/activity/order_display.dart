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
          final data = state.data!.data!;
          return data.isEmpty == true
              ? Center(
                  child: Text("No Order"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemCardHistory(
                      orderId: data[index].orderId.toString(),
                      status: data[index].status,
                      subTitle: data[index].title,
                      title: data[index].serviceType,
                      totalPayment: data[index].totalPayment,
                      isPetService: false,
                    );
                  },
                );
        } else if (state is OrderListPetSerivceLoaded) {
          final data = state.data!.data!;
          return data.isEmpty == true
              ? Center(
                  child: Text("No Order"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemCardHistory(
                      orderId: data[index].orderId.toString(),
                      status: data[index].status,
                      subTitle: data[index].title,
                      title: data[index].serviceType,
                      totalPayment: data[index].totalPayment,
                      isPetService: true,
                    );
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
