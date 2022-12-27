import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_rounded),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_box_outlined),
            color: Colors.black,
          ),
        ],
        title: const ListTile(
          title: Text('user.userName.toString()'),
          trailing: Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    profileHeaderWidget(),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: [
              const Material(
                child: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.grid_on_sharp,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.supervised_user_circle_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    gallery(),
                    gallery(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileHeaderWidget() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/photos/original.jpg'),
                  ),
                  Row(
                    children: [
                      profileData(label: 'Posts', num: '23'),
                      const SizedBox(width: 30),
                      profileData(num: '1.5M', label: 'Followers'),
                      const SizedBox(width: 30),
                      profileData(num: '123', label: 'Following'),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('user.userName.toString()'),
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('Profile info'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(0, 30),
                          side: const BorderSide(
                            color: Colors.grey,
                          )),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text('Edit profile'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 85,
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                radius: 29,
                                backgroundImage:
                                    AssetImage('assets/photos/original.jpg'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              'user.nickName.toString()',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column profileData({required String num, required String label}) {
    return Column(
      children: [
        Text(
          num,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }

  Widget gallery() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
      ],
    );
  }
}
