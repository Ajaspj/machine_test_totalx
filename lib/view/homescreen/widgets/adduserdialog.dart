import 'package:flutter/material.dart';
import 'package:machine_test_totalx/controller/add_user_controller/add_user_controller.dart';
import 'package:provider/provider.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(),
      child: AlertDialog(
        title: const Text('Add A New User'),
        content: SizedBox(
          width: 300,
          child: Consumer<UserController>(
            builder: (context, controller, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.imageFile != null
                              ? FileImage(controller.imageFile!)
                              : null,
                          child: controller.imageFile == null
                              ? Icon(Icons.camera_alt,
                                  size: 50, color: Colors.grey[700])
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Name"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Age"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: controller.ageController,
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: controller.addingUser
                              ? null
                              : () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            minimumSize: Size(100, 30),
                          ),
                          child: const Text('Cancel'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: controller.addingUser
                                ? null
                                : () async {
                                    if (await controller.save(context)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('User added Successfully'),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('User added Successfully'),
                                        ),
                                      );
                                    }
                                  },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                if (controller.addingUser) ...[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                                ]
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              minimumSize: Size(100, 30),
                            ),
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
    );
  }
}
