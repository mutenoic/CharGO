import 'package:cloud_firestore/cloud_firestore.dart';

class ChargerRentalService {

  final String chargerCollection = 'chargers';

  Future<void> rentCharger(
      String chargerId, String userId, DateTime startDate, DateTime endDate) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final rentalData = {
      'rentTime': {
        'startDate': Timestamp.fromDate(startDate),
        'endDate': Timestamp.fromDate(endDate),
      },
      'ownerID': userId,
    };

    try {
      await firestore.collection(chargerCollection).doc(chargerId).update(rentalData);
      print('Charger rented successfully!');
    } catch (e) {
      print('Error renting charger: $e');
    }
  }
}

void main() {
  final chargerRentalService = ChargerRentalService();

  final chargerId = 'aC46q5k12gO4iDTrrl1b';
  final userId = 'Bombalyanka';
  final startDate = DateTime.now();
  final endDate = DateTime.now().add(Duration(hours: 4));

  chargerRentalService.rentCharger(chargerId, userId, startDate, endDate);
}
