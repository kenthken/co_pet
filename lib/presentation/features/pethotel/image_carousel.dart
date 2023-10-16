part of pet_hotel;

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

final List<String> images = [
  'https://static.toiimg.com/thumb/msid-100100959,width-1280,resizemode-4/100100959.jpg',
  'https://www.timeoutdubai.com/cloud/timeoutdubai/2022/01/11/pet-grooming-services-in-Dubai.jpg',
  'https://www.liveabout.com/thmb/vamYI96adjJ5Sotf9hTF_VuKTI4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/female-groomer-trimming-cocker-spaniel-at-dog-grooming-salon-740521837-5a9c26618e1b6e00364237aa.jpg'
];

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIdx) {
        return Container(
          child: Center(
              child:
                  Image.network(images[index], fit: BoxFit.cover, width: 1000)),
        );
      },
    ));
  }
}
