import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tennisreminder/const/color.dart';
import '../../../../../const/text_style.dart';
import '../../../../../model/model_notice.dart';
import 'new_notice.dart';

class SettingNotice extends StatefulWidget {
  const SettingNotice({super.key});

  @override
  State<SettingNotice> createState() => _SettingNoticeState();
}

class _SettingNoticeState extends State<SettingNotice> {
  late List<ModelNotice> modelNotices;

  @override
  void initState() {
    super.initState();
    modelNotices = [];
    _fetchModelNotice();
  }

  Future<void> _fetchModelNotice() async {
    final noticeSnapshot = await FirebaseFirestore.instance.collection('notice').get();
    final List<ModelNotice> fetchedModelNotices = noticeSnapshot.docs.map((doc) {
      final data = doc.data();
      return ModelNotice.fromJson(data);
    }).toList();

    setState(() {
      modelNotices = fetchedModelNotices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            '공지사항',
        style: TS.s20w700(colorGreen900)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewNoticeRegister()),
              );
              if (result == true) {
                _fetchModelNotice();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(
            color: colorGreen900,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
          Expanded(
            child: modelNotices.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: modelNotices.length,
              itemBuilder: (context, index) {
                final notice = modelNotices[index];
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                      title: Text(
                        notice.title,
                        style: TS.s18w700(colorGreen900),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            '날짜: ${notice.date}',
                            style: TS.s14w400(colorGreen900),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: colorGreen900,
                      thickness: 1,
                      indent: 15,
                      endIndent: 15,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
