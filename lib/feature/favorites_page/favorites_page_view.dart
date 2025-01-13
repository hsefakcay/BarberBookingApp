import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/services/barber_service.dart';
import 'package:barber_booking_app/product/widgets/barber_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Barber>> favoriteBarbers;
  final BarberService _barberService = BarberService();

  @override
  void initState() {
    super.initState();
    favoriteBarbers = _barberService.fetchFavoriteBarbersDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.favorites),
      ),
      body: Padding(
        padding: context.padding.low,
        child: SizedBox(
          height: context.general.mediaSize.height,
          child: FutureBuilder(
            future: favoriteBarbers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorConstants.yellowColor),
                );
              }
              if (snapshot.hasError) {
                return const Placeholder();
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No favorite barbers found'));
              }
              final barbers = snapshot.data!;

              return _favoriteBarberListView(barbers);
            },
          ),
        ),
      ),
    );
  }

  ListView _favoriteBarberListView(List<Barber> barbers) {
    return ListView.builder(
      itemCount: barbers.length,
      itemBuilder: (context, index) {
        final barber = barbers[index];
        return Padding(
          padding: context.padding.onlyBottomLow,
          child: BarberCard(barber: barber),
        );
      },
    );
  }
}
