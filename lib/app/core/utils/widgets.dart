import 'package:flutter/material.dart';

class AppWidgets {
  static Widget loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  static Widget errorWidget(
    String message, {
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  static Widget loadingListTile() {
    return const ListTile(
      leading: CircularProgressIndicator(),
      title: Text('Loading...'),
    );
  }

  static Widget emptyState(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
