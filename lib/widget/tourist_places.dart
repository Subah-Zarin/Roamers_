import 'package:flutter/material.dart';
import 'package:roamers/models/tourist_places_model.dart';
import 'package:roamers/detail_screen.dart';

import 'detail_screen.dart';

class TouristPlaces extends StatelessWidget {
  const TouristPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigate to the DetailScreen when the chip is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(place: touristPlaces[index]),
                ),
              );
            },
            child: Chip(
              label: Text(touristPlaces[index].name),
              avatar: CircleAvatar(
                backgroundImage: AssetImage(touristPlaces[index].image),
              ),
              backgroundColor: Colors.white,
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
        const Padding(padding: EdgeInsets.only(right: 10)),
        itemCount: touristPlaces.length,
      ),
    );
  }
}
