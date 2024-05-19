import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/model_court.dart';


class CourtSeoul extends StatelessWidget {
  const CourtSeoul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서울 코트'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('court')
            .where('location', isEqualTo: '서울시') // 위치가 '서울시'인 코트 필터링
            .snapshots(),
        builder: (context, snapshot) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final ModelCourt court = ModelCourt.fromJson(documents[index].data() as Map<String, dynamic>);
              return ListTile(
                title: Text(court.name),
                subtitle: Text(court.location),
                // 여기에 원하는 코트 정보를 보여주는 코드를 작성할 수 있습니다.
              );
            },
          );
        },
      ),
    );
  }
}
