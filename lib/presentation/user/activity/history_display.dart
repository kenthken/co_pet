part of history_screen;

class HistoryDisplay extends StatefulWidget {
  const HistoryDisplay({super.key});

  @override
  State<HistoryDisplay> createState() => _HistoryDisplayState();
}

class _HistoryDisplayState extends State<HistoryDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: historyListCubit,
      builder: (context, state) {
        debugPrint("state history $state");
        if (state is HistoryListLoading) {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 162, 255)),
          );
        } else if (state is HistoryListLoaded) {
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
                      serviceType: data[index].serviceType,
                      status: data[index].status,
                      subTitle: data[index].title,
                      title: data[index].serviceType,
                      totalPayment: data[index].totalPayment,
                      isPetService: false,
                    );
                  },
                );
        } else if (state is HistoryListPetServiceLoaded) {
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
          child: Text("No History"),
        );
      },
    );
  }
}
