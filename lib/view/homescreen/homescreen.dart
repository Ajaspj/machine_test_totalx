import 'package:flutter/material.dart';
import 'package:machine_test_totalx/controller/firestore_controller/firestore_controller.dart';
import 'package:machine_test_totalx/controller/homescreen_controller/homescreen_controller.dart';
import 'package:machine_test_totalx/view/add_user_screen/add_user_screen.dart';
import 'package:machine_test_totalx/view/homescreen/widgets/showdialog.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomescreenController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const Icon(Icons.location_on, color: Colors.white),
          title: const Text(
            "Nilambur",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<HomescreenController>(
          builder: (context, homeScreenController, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) =>
                              homeScreenController.setSearchText(value),
                          decoration: InputDecoration(
                            hintText: "Search users...",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: IconButton(
                          icon: const Icon(Icons.sort, color: Colors.white),
                          onPressed: () {
                            showSortBottomSheet(
                                context,
                                homeScreenController.sortOption,
                                homeScreenController.setSortOption);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("Users Lists"),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Consumer<FirestoreController>(
                      builder: (BuildContext context,
                              FirestoreController controller, Widget? child) =>
                          ListView.builder(
                        itemCount: controller.users.length,
                        itemBuilder: (context, index) {
                          var user = controller.users[index];

                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: const Offset(
                                      0, 3), // shadow direction: bottom right
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: user.image == null
                                      ? null
                                      : NetworkImage(user.image!),
                                  child: user.image != null
                                      ? null
                                      : const Icon(Icons.person),
                                  radius: 30, // Adjust the radius as needed
                                ),
                                const SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Age: ${user.age ?? ''}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const AddUserDialog(),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
