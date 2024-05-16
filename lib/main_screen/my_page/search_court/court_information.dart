import 'package:flutter/material.dart';

import '../../../model/model_court.dart';

class CourtInformation extends StatefulWidget {
  final ModelCourt modelCourt;
  const CourtInformation({super.key, required this.modelCourt});

  @override
  State<CourtInformation> createState() => _CourtInformationState();
}

class _CourtInformationState extends State<CourtInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('court information'),
      ),
    );
  }
}
