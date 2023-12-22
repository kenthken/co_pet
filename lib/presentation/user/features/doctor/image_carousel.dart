import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselDoctorScreen extends StatefulWidget {
  const ImageCarouselDoctorScreen({super.key});

  @override
  State<ImageCarouselDoctorScreen> createState() =>
      _ImageCarouselDoctorScreenState();
}

final List<String> imgList = [
  'https://plus.unsplash.com/premium_photo-1663045912941-b82a0cd5c175?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV0JTIwZG9jdG9yfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
  'https://plus.unsplash.com/premium_photo-1661963919820-d201e373bb12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
  'https://plus.unsplash.com/premium_photo-1661961347317-41f7a010a441?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHBldCUyMGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
];

class _ImageCarouselDoctorScreenState extends State<ImageCarouselDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
      items: imgList
          .map((item) => Container(
                child: Center(
                    child: Image.network(item, fit: BoxFit.cover, width: 1000)),
              ))
          .toList(),
    ));
  }
}
