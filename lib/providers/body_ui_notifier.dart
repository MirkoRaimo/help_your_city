import 'package:flutter/material.dart';
import 'package:help_your_city/db/models/basic_card_model.dart';
import 'package:help_your_city/ui/elements/news_preview.dart';
import 'package:provider/provider.dart';

import 'shops_notifier.dart';

class BodyUINotifier extends ChangeNotifier {
  Widget? cityBody;
  Widget? citizenBody;
  Widget? eventsBody;
  static Widget? _shopsBody;

  static Widget getShopsBody(BuildContext context) {
    _shopsBody ??=
        _buildGenericBody(Provider.of<ShopsNotifier>(context).cardModels);

    return _shopsBody!;
  }

  static Widget _buildGenericBody(List<BasicCardModel> cardModels) {
    return cardModels.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: cardModels.length,
            itemBuilder: ((context, index) {
              BasicCardModel cardModel = cardModels[index];
              return newsPreview(
                  context, cardModel.image, cardModel.title, cardModel.body);
            }),
          );
  }
}
