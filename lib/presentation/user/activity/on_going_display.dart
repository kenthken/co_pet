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
          return Center(
            child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 0, 162, 255)),
          );
        } else if (state is OnGoingListLoaded) {
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
