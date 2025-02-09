import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/howto/img_avatar.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie, color: Colors.black),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, 'movies');
              },
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.black),
              title: Text('Movie Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/movie_dashboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.tv, color: Colors.black),
              title: Text('TV Shows'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/tv_shows');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Logout'),
              onTap: () {
                // Handle logout logic
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}