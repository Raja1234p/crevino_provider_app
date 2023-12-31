import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/auth/auth_user_services.dart';
import 'package:handyman_provider_flutter/components/app_widgets.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/user_data.dart';
import 'package:handyman_provider_flutter/screens/chat/components/user_item_widget.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/empty_error_state_widget.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        languages.lblChat,
        textColor: white,
        showBack: Navigator.canPop(context),
        textSize: APP_BAR_TEXT_SIZE,
        elevation: 3.0,
        backWidget: BackWidget(),
        color: context.primaryColor,
      ),
      body: appStore.uid.validate().isNotEmpty
          ? FirestorePagination(
              itemBuilder: (context, snap, index) {
                UserData contact = UserData.fromJson(snap.data() as Map<String, dynamic>);

                return UserItemWidget(userUid: contact.uid.validate());
              },
              physics: AlwaysScrollableScrollPhysics(),
              query: chatServices.fetchChatListQuery(userId: appStore.uid.validate()),
              onEmpty: NoDataWidget(
                title: languages.noConversation,
                subTitle: languages.noConversationSubTitle,
                imageWidget: EmptyStateWidget(),
              ).paddingSymmetric(horizontal: 16),
              initialLoader: LoaderWidget(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 10),
              isLive: true,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 60),
              limit: PER_PAGE_CHAT_LIST_COUNT,
              separatorBuilder: (_, i) => Divider(height: 0, indent: 82, color: context.dividerColor),
              viewType: ViewType.list,
            )
          : NoDataWidget(
              title: languages.noConversation,
              subTitle: languages.noConversationSubTitle,
              imageWidget: EmptyStateWidget(),
              retryText: languages.connectWithFirebaseForChat,
              onRetry: () {
                setUserInFirebaseIfNotRegistered(context);
              },
            ).paddingSymmetric(horizontal: 16),
    );
  }
}
