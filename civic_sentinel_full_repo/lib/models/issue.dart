import 'package:cloud_firestore/cloud_firestore.dart';

class Issue {
  final String id;
  final String userId;
  final String category;
  final String description;
  final String? mediaUrl;
  final GeoPoint location;
  final String status;
  final Timestamp createdAt;
  final int? rating;
  final String? feedback;

  Issue({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.location,
    required this.status,
    required this.createdAt,
    this.mediaUrl,
    this.rating,
    this.feedback,
  });

  factory Issue.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Issue(
      id: doc.id,
      userId: data['userId'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      mediaUrl: data['mediaUrl'],
      location: data['location'] ?? GeoPoint(0, 0),
      status: data['status'] ?? 'Reported',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      rating: data['feedback']?['rating'],
      feedback: data['feedback']?['comment'],
    );
  }
}