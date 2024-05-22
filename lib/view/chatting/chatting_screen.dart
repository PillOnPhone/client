import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_on_phone/config/font_system.dart'; // Make sure to import this for font styles
import 'package:pill_on_phone/repository/chatting/chatting_repository.dart';
import 'package:pill_on_phone/view/base/base_screen.dart';
import 'package:pill_on_phone/view/chatting/widget/chatting_list_widget.dart';
import 'package:pill_on_phone/view_model/chatting/chatting_view_model.dart';

import '../../provider/Chatting/chatting_provider.dart';

class ChattingScreen extends BaseScreen<ChattingViewModel> {
  const ChattingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final ChattingViewModel viewModel = Get.put(
      ChattingViewModel(
        repository: ChattingRepository(
          chattingProvider: Get.put(ChattingProvider()),
        ),
      ),
    );
    viewModel.loadChatData(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Padding(
          padding: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
          child: Text(
            "채팅",
            style: FontSystem.H1,
          ),
        ),

        Expanded(
          child:
          Obx(() {
            if (viewModel.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage.value));
            } else {
              return ListView.builder(
                itemCount: viewModel.chatList.length,
                itemBuilder: (context, index) {
                  final chat = viewModel.chatList[index];
                  return ChatListItem(chatItem: chat);
                },
              );
            }
          }),
        ),
      ],
    );
  }
}

