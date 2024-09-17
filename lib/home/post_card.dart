import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                post['user']['profileImageUrl'] ??
                    'https://via.placeholder.com/150',
              ),
            ),
            title: Text(
              post['user']['username'] ?? 'Unknown User',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              'Posted on ${post['createdAt'] ?? 'Unknown Date'}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Add functionality for post options
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              // Add functionality for image preview
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.network(
                post['imageUrl'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    height: 250,
                    child: Center(
                      child: Icon(Icons.broken_image,
                        size: 60, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['caption'] ?? 'No caption available',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red, size: 20),
                        SizedBox(width: 4.0),
                        Text('${post['likes']} Likes',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Add functionality for comments
                      },
                      child:
                          Text('View Comments', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
