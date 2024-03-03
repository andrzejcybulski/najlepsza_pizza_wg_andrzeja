import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_wg_andrzeja/app/home/add_opinion/add_opinion_page_content.dart';
import 'package:najlepsza_pizza_wg_andrzeja/app/home/my_account/my_account_page_content.dart';
import 'package:najlepsza_pizza_wg_andrzeja/app/home/restarurants/restaurants_page_conent.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            if (currentIndex == 0) {
              return const Text('Najlepsza pizza wg Andrzeja - OPINIE');
            }
            if (currentIndex == 1) {
              return const Text('Najlepsza pizza wg Andrzeja - DODAJ');
            }

            return const Text('Najlepsza pizza wg Andrzeja - KONTO');
          },
        ),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return RestaurantsPageContent();
        }
        if (currentIndex == 1) {
          return AddOpinionPageContent();
        }

        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Opinie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dodaj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
        ],
      ),
    );
  }
}
