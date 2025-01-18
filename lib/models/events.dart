import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String venue;
  final DateTime date;
  final String organizerId;
  final List<String> attendeeIds;
  final DateTime createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.venue,
    required this.date,
    required this.organizerId,
    required this.attendeeIds,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'venue': venue,
      'date': Timestamp.fromDate(date),
      'organizerId': organizerId,
      'attendeeIds': attendeeIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    return EventModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      venue: map['venue'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      organizerId: map['organizerId'] ?? '',
      attendeeIds: List<String>.from(map['attendeeIds'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
