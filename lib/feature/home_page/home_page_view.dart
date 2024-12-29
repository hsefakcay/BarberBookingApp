import 'package:barber_booking_app/feature/home_page/home_page_mixin.dart';
import 'package:barber_booking_app/feature/settings_page/settings_page_view.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/enums/icon_size.dart';

import 'package:barber_booking_app/product/widgets/barber_card_widget.dart';
import 'package:barber_booking_app/product/widgets/barbershop_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kartal/kartal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: context.general.mediaSize.height * 0.062,
        title: _appBarTitle(appLocalizations, context),
        leading: _notificationButton(),
        actions: [_settingsButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _helloTextRow(appLocalizations, context),
              SizedBox(height: context.general.mediaSize.height * 0.03),
              _searchTextField(appLocalizations),
              SizedBox(height: context.general.mediaSize.height * 0.03),
              _latestVisitRow(appLocalizations, context),
              SizedBox(height: context.general.mediaSize.height * 0.03),
              _nearbyBarbershops(appLocalizations, context),
              SizedBox(height: context.general.mediaSize.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Text _appBarTitle(AppLocalizations? appLocalizations, BuildContext context) {
    return Text(
      appLocalizations?.date ?? '',
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  IconButton _settingsButton() {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: ColorConstants.greyColor,
        size: IconSize.medium.value,
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute<SettingsPage>(builder: (context) => const SettingsPage()));
      },
    );
  }

  IconButton _notificationButton() {
    return IconButton(
      icon: Icon(
        Icons.notifications,
        color: ColorConstants.greyColor,
        size: IconSize.medium.value,
      ),
      onPressed: () {},
    );
  }

  Row _helloTextRow(AppLocalizations? appLocalizations, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${appLocalizations?.welcomeMessage ?? ""},",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          FirebaseAuth.instance.currentUser?.refreshToken ?? '',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Column _nearbyBarbershops(
    AppLocalizations? appLocalizations,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            StringConstants.barberShops,
            style:
                Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorConstants.greyColor),
          ),
        ),
        SizedBox(
          height: context.general.mediaSize.height * 0.47,
          child: FutureBuilder(
            future: barberShops,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Placeholder());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No barbers found'));
              }
              final barberShops = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: barberShops.length,
                itemBuilder: (context, index) {
                  final barberShop = barberShops[index];
                  return SizedBox(
                    width: context.general.mediaSize.width * 0.6,
                    child: BarberShopCard(barberShop: barberShop),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column _latestVisitRow(AppLocalizations? appLocalizations, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            StringConstants.barbers,
            style:
                Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorConstants.greyColor),
          ),
        ),
        _barberListView(context.general.mediaSize.height),
      ],
    );
  }

  TextField _searchTextField(AppLocalizations? appLocalizations) {
    return TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstants.darkGreyColor,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: ColorConstants.yellowColor,
        hintText: appLocalizations?.search ?? '',
        hintStyle: const TextStyle(
          color: ColorConstants.greyColor,
        ),
      ),
    );
  }

  SizedBox _barberListView(double height) {
    return SizedBox(
      height: height * 0.12,
      child: FutureBuilder(
        future: barbers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Placeholder();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No barbers found'));
          }
          final barbers = snapshot.data!;

          return ListView.builder(
            itemCount: barbers.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final barber = barbers[index];
              return BarberCard(barber: barber);
            },
          );
        },
      ),
    );
  }
}
