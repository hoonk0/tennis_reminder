import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../const/model/model_court.dart';
import '../route/home/court_search/court_information.dart';

class CourtGridView extends StatelessWidget {
  final List<ModelCourt> listCourt; // ModelCourt 리스트를 받습니다.

  CourtGridView({required this.listCourt});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      crossAxisCount: 1,
      itemCount: listCourt.length,
      itemBuilder: (context, index) {
        final ModelCourt modelCourt = listCourt[index];

        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RouteCourtInformation(courtId: modelCourt.id,)));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 코트 이미지 또는 기본 아이콘
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: modelCourt.imagePath.isNotEmpty
                      ? Image.network(
                    modelCourt.imagePath,
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      // 이미지 로드 실패 시 기본 아이콘 표시
                      return Container(
                        height: 120,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_not_supported, // 대체 아이콘
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  )
                      : Container(
                    height: 120,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported, // 대체 아이콘
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 코트 이름
                      Text(
                        modelCourt.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      // 코트 주소
                      Text(
                        modelCourt.location,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
