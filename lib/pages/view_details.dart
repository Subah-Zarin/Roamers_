import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("View Details"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            _buildAttractionDetails(context, size),
            const SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAttractionDetails(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.4,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: 180,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Hanging Bridge of Rangamati.png.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 30,
                  icon: const Icon(Ionicons.chevron_back),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Hanging Bridge of Rangamati",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Per person: 2000TK",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Jhulonto Bridge in Bengali)is the landmark icon of Rangamati. It's a popular tourist spot and a must go destination. It is also connected by waterway from Kaptai.",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _buildNumberOfPeopleSelector(),
        ),
      ],
    );
  }

  Widget _buildNumberOfPeopleSelector() {
    int selectedNumberOfPeople = 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Number of people: "),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: selectedNumberOfPeople,
          onChanged: (value) {
            // Handle onChanged
          },
          items: List.generate(
            5,
                (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text((index + 1).toString()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {

          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange, // Background color of the button
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding as needed
          ),
          child: Text(
            'Hotels',
            style: TextStyle(
              color: Colors.white, // Text color of the button
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {

          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding as needed
          ),
          child: Text(
            'Tickets',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
