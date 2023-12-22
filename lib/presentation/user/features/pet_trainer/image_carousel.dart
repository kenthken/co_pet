import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselPetTrainerScreen extends StatefulWidget {
  const ImageCarouselPetTrainerScreen({super.key});

  @override
  State<ImageCarouselPetTrainerScreen> createState() =>
      _ImageCarouselPetTrainerScreenState();
}

final List<String> imgList = [
  'https://media.istockphoto.com/id/1280731582/photo/corgi-puppy-sit-in-front-of-a-woman-looking-up.webp?b=1&s=170667a&w=0&k=20&c=4nIoYsT2qnpKwLQ1zD0FDZoIiD0NeAecNyTYt25UYeM=',
  'https://media.istockphoto.com/id/83356884/photo/line-of-purebred-dogs-in-obiedience-class.webp?b=1&s=170667a&w=0&k=20&c=dJmZUSM06hiz54KMoRPBI0TVzI-FJ_XoDzjYxnPs46E=',
  'https://media.istockphoto.com/id/1400789995/photo/chocolate-white-border-collie-with-woman-owner.webp?b=1&s=170667a&w=0&k=20&c=ngwOiNTKtdLbv5K6_MEOvsFbZOC1ez-113Zhfi_vmqU=',
];

class _ImageCarouselPetTrainerScreenState
    extends State<ImageCarouselPetTrainerScreen> {
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
