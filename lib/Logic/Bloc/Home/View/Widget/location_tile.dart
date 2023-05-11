library location_tile;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: Text('A'),
              ),
            ),
          ),
          title: Text('Service point - A', style: GoogleFonts.ubuntu()),
          trailing: const LocationTag(),
          // trailing: Icon(Icons.abc),
        ),
        const Divider(),
      ],
    );
  }
}

class LocationTag extends StatelessWidget {
  const LocationTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Container(
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('E'),
            ),
          ),
          Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'Assets/icons/bicycle.png',
                scale: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
