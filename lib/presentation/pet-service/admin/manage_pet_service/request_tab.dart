part of manage_pet_service;

class RequestTab extends StatefulWidget {
  const RequestTab({super.key});

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  Widget card(DataPetService.Datum data) {
    return ListTile(
      onTap: () {
        final StatefulWidget destination;
        data.serviceType.toLowerCase() == "toko"
            ? destination = HotelGroomingManageServiceScreen(
                id: data.penyediaId.toString(),
                isAdmin: true,
              )
            : data.serviceType.toLowerCase() == "dokter"
                ? destination = DoctorManageServiceScreen(
                    id: data.id.toString(),
                    isAdmin: true,
                  )
                : destination = TrainerManageServiceScreen(
                    id: data.id.toString(),
                    isAdmin: true,
                  );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destination,
            ));
      },
      title: Text(data.nama),
      leading: CircleAvatar(
          child: data.foto != null
              ? Image.memory(base64Decode(data.foto))
              : const Icon(Icons.person)),
      trailing: IconButton(
          onPressed: () async {
            bool acceptSuccess = false;
            SmartDialog.showLoading(
              backDismiss: true,
              builder: (context) => const SpinKitWave(
                color: Color.fromARGB(255, 0, 162, 255),
                size: 50,
              ),
            );
            if (data.serviceType.toLowerCase() == "toko") {
              acceptSuccess =
                  await AdminRepository().acceptToko(data.id.toString());
            } else if (data.serviceType.toLowerCase() == "dokter") {
              acceptSuccess =
                  await AdminRepository().acceptDoctor(data.id.toString());
            } else if (data.serviceType.toLowerCase() == "trainer") {
              acceptSuccess =
                  await AdminRepository().acceptTrainer(data.id.toString());
            }

            if (acceptSuccess) {
              requestListCubit.getRequestList();
              userPetServiceListCubit.getUserPetServiceList();
              Fluttertoast.showToast(
                  msg: "Accept Success",
                  backgroundColor: Colors.white,
                  textColor: Colors.black);
            } else {
              Fluttertoast.showToast(
                  msg: "Please try again later",
                  backgroundColor: Colors.white,
                  textColor: Colors.black);
            }
            SmartDialog.dismiss();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          icon: const Icon(
            Icons.done,
            color: Colors.white,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: requestListCubit,
      builder: (context, state) {
        if (state is RequestListLoading) {
          return const SpinKitWave(
            color: Color.fromARGB(255, 0, 162, 255),
            size: 50,
          );
        }
        if (state is RequestListLoaded) {
          final data = state.data!.data;
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => card(data[index]),
            );
          } else {
            return const Center(
              child: Text("No Request"),
            );
          }
        }
        return const Center(
          child: Text("No Request"),
        );
      },
    );
  }
}
