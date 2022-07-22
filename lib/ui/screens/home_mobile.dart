import 'package:flutter/material.dart';
import 'package:help_your_city/db/models/basic_card_model.dart';
import 'package:help_your_city/providers/bottom_nav_bar_notifier.dart';
import 'package:help_your_city/providers/citizens_notifier.dart';
import 'package:help_your_city/providers/city_notifier.dart';
import 'package:help_your_city/providers/events_notifier.dart';
import 'package:help_your_city/providers/shops_notifier.dart';
import 'package:help_your_city/ui/elements/news_preview.dart';
import 'package:provider/provider.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({Key? key}) : super(key: key);

  final String _selectedCity = 'Vinci';

  @override
  Widget build(BuildContext context) {
    initMockData(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          children: [
            Text(_selectedCity),
            //TODO: add a dropdown
            const Text(' - Sovigliana'),
            Expanded(child: Container()),
            Flexible(
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(
                      Rect.fromLTRB(30, 30, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/engineering_logo.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      body: buildBody(context),
      bottomNavigationBar: buildBottomNavBar(_selectedCity),
      floatingActionButton:
          Provider.of<BottomNavBarNotifier>(context).currentTab == 1
              ? FloatingActionButton(
                  tooltip: 'Effettua una segnalazione',
                  child: const Icon(Icons.add),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Text('Ancora da implementare...'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                )
              : Container(),
    );
  }

  Widget buildBody(BuildContext context) {
    switch (Provider.of<BottomNavBarNotifier>(context).currentTab) {
      case 0:
        return buildCityBody(context);
      case 1:
        return buildCitizensBody(context);
      case 2:
        // eventsBody ??= buildEventsBody(context);
        return buildEventsBody(context);
      case 3:
        return buildShopsBody(context);
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

Widget buildBottomNavBar(String selectedCity) {
  return Consumer<BottomNavBarNotifier>(
    builder: (context, model, child) {
      return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.location_city),
            label: selectedCity,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Cittadini',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
            ),
            label: 'Eventi',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_sharp),
            label: 'Nuove attività',
          ),
        ],
        elevation: 0,
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        currentIndex: model.currentTab,
        onTap: (int currentTab) => model.setCurrentTab(currentTab),
      );
    },
  );
}

void initMockData(BuildContext context) {
  Provider.of<CityNotifier>(context, listen: false).initCardModel(
    [
      BasicCardModel(
        image: 'assets/images/siccita.jpeg',
        title: 'Allarme siccità',
        body:
            'A causa del caldo anomalo di questi giorni, vi chiediamo di limitare i consumi d\'acqua',
      ),
    ],
  );

  Provider.of<CitizensNotifier>(context, listen: false).initCardModel(
    [
      BasicCardModel(
        image: 'assets/images/alberi_pericolanti.jpeg',
        title: 'Attenzione!',
        body: 'Alberi pericolanti in via Fasulla, n°123',
      ),
    ],
  );

  Provider.of<EventsNotifier>(context, listen: false).initCardModel(
    [
      BasicCardModel(
        image: 'assets/images/giorno-leonardo-da-vinci-2019.jpeg',
        title: 'Giorno di Leonardo',
        body: 'Anche quest\'anno a Vinci si festeggerà il giorno di Leonardo!',
      ),
      BasicCardModel(
        image: 'assets/images/festa_unicorno.jpeg',
        title: 'Festa dell\'unicorno!',
        body:
            'Il mondo fantasy torna a Vinci!\n\nCome ogni anno, l\'antico borgo si popolerà di gnomi, fate e tanti altri animali fantastici!',
      ),
    ],
  );

  Provider.of<ShopsNotifier>(context, listen: false).initCardModel(
    [
      BasicCardModel(
        image: 'assets/images/inaugurazione-gelateria.jpeg',
        title: '\'Gelateria Nuova\' apre il suo primo negozio!',
        body:
            '''In via Inesistente n°5, Mario Rossi ha aperto una gelateria.\n\nMario Rossi ha sempre amato il gelato così, a soli 23 anni, ha deciso di aprire una gelateria.\nNoi del comune di Vinci siamo sempre orgogliosi quando i cittadini si mettono in gioco, pertanto, non possiamo che augurargli il meglio!''',
      ),
    ],
  );
}

Widget buildCityBody(BuildContext context) {
  return buildGenericBody(
      context, Provider.of<CityNotifier>(context, listen: false).cardModels);
}

Widget buildCitizensBody(BuildContext context) {
  return buildGenericBody(context,
      Provider.of<CitizensNotifier>(context, listen: false).cardModels);
}

Widget buildEventsBody(BuildContext context) {
  return buildGenericBody(
      context, Provider.of<EventsNotifier>(context, listen: false).cardModels);
}

Widget buildShopsBody(BuildContext context) {
  return buildGenericBody(
      context, Provider.of<ShopsNotifier>(context, listen: false).cardModels);
}

Widget buildGenericBody(BuildContext context, List<BasicCardModel> cardModels) {
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
