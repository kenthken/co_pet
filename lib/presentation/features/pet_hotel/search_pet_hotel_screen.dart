import 'package:flutter/material.dart';

class SearchPetHotelScreen extends StatefulWidget {
  const SearchPetHotelScreen({super.key});

  @override
  State<SearchPetHotelScreen> createState() => _SearchPetHotelScreenState();
}

class _SearchPetHotelScreenState extends State<SearchPetHotelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close_rounded)),
        title: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: const TextField(
              decoration: InputDecoration(
                  hintText: "Search",
                  icon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 0, 162, 255),
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey))),
        ),
      ),
    );
  }
}
