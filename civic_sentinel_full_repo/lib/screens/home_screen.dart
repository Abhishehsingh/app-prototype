import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'report_screen.dart';
import 'issue_detail_screen.dart';
import 'map_screen.dart';
import '../widgets/issue_card.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final _auth = AuthService();
  final _fire = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Civic Sentinel'),
        actions: [
          IconButton(icon: Icon(Icons.map), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()))),
          IconButton(icon: Icon(Icons.logout), onPressed: () async => await _auth.signOut()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportScreen())),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fire.collection('issues').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return Center(child: CircularProgressIndicator());
          final docs = snap.data!.docs;
          if (docs.isEmpty) return Center(child: Text('No issues reported yet'));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final doc = docs[i];
              return IssueCard(
                doc: doc,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => IssueDetailScreen(issueId: doc.id))),
              );
            },
          );
        },
      ),
    );
  }
}