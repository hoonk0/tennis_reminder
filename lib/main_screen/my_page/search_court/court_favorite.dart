import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/service/provider/providers.dart';

import '../../../const/color.dart';
import '../../../const/text_style.dart';
import '../../../model/model_court.dart';

class CourtFavorite extends StatefulWidget {
  const CourtFavorite({super.key});

  @override
  State<CourtFavorite> createState() => _CourtFavoriteState();
}

class _CourtFavoriteState extends State<CourtFavorite> {
  final ValueNotifier<List<ModelCourt>> vnListModelCourt = ValueNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListModelCourt();
  }

  Future<void> getListModelCourt() async {
    // 1. 코드 ID를 불러오고
    // 2. ID를 가지고 List<ModelCourt> 를 만들어준다
    final myFavoriteCourtIds = userNotifier.value!.favorites;
    final listFuture = myFavoriteCourtIds.map((id) => FirebaseFirestore.instance.collection('court').doc(id).get()).toList();
    final courtDocs = await Future.wait(listFuture);
    // result = [doc1, doc2, doc3, doc4, ......];
    final List<ModelCourt> listModelCourt = courtDocs.map((courtDoc) {
      return ModelCourt.fromJson(courtDoc.data()!);
    }).toList();
    vnListModelCourt.value = listModelCourt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorite court'),
      ),
      body: ValueListenableBuilder(
        valueListenable: vnListModelCourt,
        builder: (context, listModelCourt, child) => SingleChildScrollView(
          child: Column(
            children: List.generate(listModelCourt.length, (index) => Text(listModelCourt[index].name, style: TS.s15w500(colorGray500))),
          ),
        ),
      ),
    );
  }
}
