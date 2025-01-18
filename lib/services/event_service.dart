import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_talks/models/events.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new event
  Future<String> createEvent(EventModel event) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('events').add(event.toMap());
      return docRef.id;
    } catch (e) {
      print('Error creating event: $e');
      rethrow;
    }
  }

  // Get all upcoming events
  Stream<List<EventModel>> getUpcomingEvents() {
    return _firestore
        .collection('events')
        .where('date', isGreaterThan: Timestamp.fromDate(DateTime.now()))
        .orderBy('date')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Get user's events (both organized and attended)
  Stream<List<EventModel>> getUserEvents(String userId) {
    return _firestore
        .collection('events')
        .where(Filter.or(
          Filter('organizerId', isEqualTo: userId),
          Filter('attendeeIds', arrayContains: userId),
        ))
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Register for an event
  Future<void> registerForEvent(String eventId, String userId) async {
    await _firestore.collection('events').doc(eventId).update({
      'attendeeIds': FieldValue.arrayUnion([userId])
    });
  }

  // Unregister from an event
  Future<void> unregisterFromEvent(String eventId, String userId) async {
    await _firestore.collection('events').doc(eventId).update({
      'attendeeIds': FieldValue.arrayRemove([userId])
    });
  }

  // Delete an event (only organizer can delete)
  Future<void> deleteEvent(String eventId) async {
    await _firestore.collection('events').doc(eventId).delete();
  }

  // Update an event (only organizer can update)
  Future<void> updateEvent(EventModel event) async {
    await _firestore.collection('events').doc(event.id).update(event.toMap());
  }

  Stream<List<EventModel>> getPastEvents(String userId) {
    final now = DateTime.now();

    return _firestore
        .collection('events')
        .where('date', isLessThan: Timestamp.fromDate(now))
        .where('attendeeIds', arrayContains: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Get upcoming events for a specific user
}
