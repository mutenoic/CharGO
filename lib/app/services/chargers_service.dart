import 'package:cloud_firestore/cloud_firestore.dart';

class ChargerRentalService {
  final String chargerCollection = 'chargers';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> rentCharger(String chargerId, String userId, DateTime startDate, DateTime endDate) async {
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

  const chargerId = 'aC46q5k12gO4iDTrrl1b';
  const userId = 'Bombalyanka';
  final startDate = DateTime.now();
  final endDate = DateTime.now().add(const Duration(hours: 4));

  chargerRentalService.rentCharger(chargerId, userId, startDate, endDate);
}
