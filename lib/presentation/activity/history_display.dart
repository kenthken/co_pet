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
          return Center(
            child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 0, 162, 255)),
          );
        } else if (state is HistoryListLoaded) {
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
          child: Text("No History"),
        );
      },
    );
  }
}
