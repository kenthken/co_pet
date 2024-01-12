import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorManageServiceScreen extends StatefulWidget {
  const DoctorManageServiceScreen({super.key});

  @override
  State<DoctorManageServiceScreen> createState() =>
      _DoctorManageServiceScreenState();
}

class _DoctorManageServiceScreenState extends State<DoctorManageServiceScreen> {
  TextEditingController _name = TextEditingController(),
      _str = TextEditingController(),
      _address = TextEditingController(),
      _education = TextEditingController(),
      _price = TextEditingController(),
      _experience = TextEditingController(),
      _specialist = TextEditingController();
  bool nameRead = false,
      strRead = false,
      addressRead = false,
      educationRead = false,
      priceRead = false,
      experienceRead = false,
      specialistRead = false,
      open = false;
      
  Widget textField(
      String title, TextEditingController controller, bool readOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: !readOnly
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            // if (title == "Store Name") {
                            //   storeNameOnEdit = !storeNameOnEdit;
                            // } else if (title == "Store Location") {
                            //   storeLoactionOnEdit = !storeLoactionOnEdit;
                            // }
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 162, 255)),
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            // if (title == "Store Name") {
                            //   storeNameOnEdit = !storeNameOnEdit;
                            // } else if (title == "Store Location") {
                            //   debugPrint("$title");
                            //   storeLoactionOnEdit = !storeLoactionOnEdit;
                            // }
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        )),
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 154, 154, 154),
                    fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Service"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: 50.w,
                    width: 100.w,
                    child: Image.asset("assets/petDoctor/doctor.jpg")),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                )
              ],
            ),
            Container(
              width: 100.w,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Accept patient at the moment?",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 116, 115, 115),
                                fontSize: 12.sp)),
                        Switch(
                          // This bool value toggles the switch.
                          value: open,
                          activeColor: const Color.fromARGB(255, 0, 162, 255),
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              open = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  textField("Name", _name, nameRead),
                  textField("No STR", _str, strRead),
                  textField("Education", _education, educationRead),
                  textField(
                      "Profesional Placement Address", _address, addressRead),
                  textField("Experience", _experience, experienceRead),
                  textField("Price /30 minute session", _price, priceRead)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
