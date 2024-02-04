part of history_screen;

class OnGoingDisplay extends StatefulWidget {
  const OnGoingDisplay({super.key});

  @override
  State<OnGoingDisplay> createState() => _OnGoingDisplayState();
}

class _OnGoingDisplayState extends State<OnGoingDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: onGoingListCubit,
      builder: (context, state) {
        debugPrint("state ongoing $state");
        if (state is OnGoingListLoading) {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 162, 255)),
          );
        } else if (state is OnGoingListLoaded) {
          final data = state.data!.data!;
          return data.isEmpty == true
              ? const Center(
                  child: Text("No Order"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemCardHistory(
                      orderId: data[index].orderId.toString(),
                      status: data[index].status,
                      serviceType: data[index].serviceType,
                      subTitle: data[index].title,
                      title: data[index].serviceType,
                      totalPayment: data[index].totalPayment,
                      isPetService: false,
                    );
                  },
                );
        } else if (state is OnGoingListPetServiceLoaded) {
          final data = state.data!.data!;
          return data.isEmpty == true
              ? const Center(
                  child: Text("No Order"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemCardHistory(
                      orderId: data[index].orderId.toString(),
                      status: data[index].status,
                      subTitle: data[index].title,
                      serviceType: data[index].serviceType,
                      title: data[index].serviceType,
                      totalPayment: data[index].totalPayment,
                      isPetService: true,
                    );
                  },
                );
        }
        return const Center(
          child: Text("No Order"),
        );
      },
    );
  }
}
