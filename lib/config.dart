// Stream config
import 'package:flutter/material.dart';

const streamKey = 'YOUR_KEY'; // TODO: ADD YOUR STREAM PROJECT KEY

const userGordon = DemoUser(
  id: 'gordon',
  name: 'Gordon Hayes',
  image: 'https://avatars.githubusercontent.com/u/13705472?v=4',
);

const userSalvatore = DemoUser(
  id: 'salvatore',
  name: 'Salvatore Giordano',
  image: 'https://avatars.githubusercontent.com/u/20601437?v=4',
);

@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}
