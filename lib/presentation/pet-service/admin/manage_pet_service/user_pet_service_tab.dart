part of manage_pet_service;

class UserPetServiceTab extends StatefulWidget {
  const UserPetServiceTab({super.key});

  @override
  State<UserPetServiceTab> createState() => _UserPetServiceTabState();
}

class _UserPetServiceTabState extends State<UserPetServiceTab> {
  Widget card(DataUserPetService.Datum data) {
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
          backgroundImage: MemoryImage(
            base64Decode(data.foto),
          ),
        ),
        trailing: Text(
          data.serviceType,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: userPetServiceListCubit,
      builder: (context, state) {
        debugPrint("state $state");
        if (state is UserPetServiceListLoading) {
          return const SpinKitWave(
            color: Color.fromARGB(255, 0, 162, 255),
            size: 50,
          );
        }
        if (state is UserPetServiceListLoaded) {
          final data = state.data!.data;
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => card(data[index]),
            );
          } else {
            return const Center(
              child: Text("No Pet Service User"),
            );
          }
        }
        return const Center(
          child: Text("No Pet Service User"),
        );
      },
    );
  }
}
