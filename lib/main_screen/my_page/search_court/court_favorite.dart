import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/service/provider/providers.dart';

import '../../../const/color.dart';
import '../../../const/text_style.dart';
import '../../../model/model_court.dart';
import 'court_information.dart';

class CourtFavorite extends StatefulWidget {
  const CourtFavorite({super.key});

  @override
  State<CourtFavorite> createState() => _CourtFavoriteState();
}

class _CourtFavoriteState extends State<CourtFavorite> {
  final ValueNotifier<List<ModelCourt>> vnListModelCourt = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    getListModelCourt();
  }

  Future<void> getListModelCourt() async {
    final myFavoriteCourtIds = userNotifier.value!.favorites;
    final listFuture = myFavoriteCourtIds.map((id) => FirebaseFirestore.instance.collection('court').doc(id).get()).toList();
    final courtDocs = await Future.wait(listFuture);
    final List<ModelCourt> listModelCourt = courtDocs.map((courtDoc) {
      return ModelCourt.fromJson(courtDoc.data()!);
    }).toList();
    vnListModelCourt.value = listModelCourt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Courts'),
      ),
      body: ValueListenableBuilder(
        valueListenable: vnListModelCourt,
        builder: (context, List<ModelCourt> listModelCourt, child) {
          if (listModelCourt.isEmpty) {
            return const Center(child: Text('No favorite courts found'));
          }
          return ListView.builder(
            itemCount: listModelCourt.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourtInformation(courtId: listModelCourt[index].id),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: colorGreen900, width: 2),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listModelCourt[index].imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listModelCourt[index].name,
                                  style: TS.s20w600(colorGreen900),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  listModelCourt[index].location,
                                  style: TS.s15w500(colorGray500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );

        },
      ),
    );
  }
}
