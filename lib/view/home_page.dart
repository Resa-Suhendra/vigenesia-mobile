import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vigenesia/model/MotivationModel.dart';
import 'package:vigenesia/model/UserModel.dart';
import 'package:vigenesia/services/MotivationService.dart';
import 'package:vigenesia/services/UserService.dart';
import 'package:vigenesia/view/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<HomePage> createState() => _HomePageState(this.userModel);
}

class _HomePageState extends State<HomePage> {
  final UserModel userModel;

  _HomePageState(this.userModel);

  final TextEditingController _motivationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String nama = userModel.nama;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.lightBlue[800],
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        title: Image.asset(
          'assets/vigenesia-logo.png',
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Show a dialog box asking the user to confirm that they want to logout.
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          EasyLoading.show(status: 'loading...');
                          Future.delayed(const Duration(seconds: 1), () {
                            EasyLoading.dismiss();
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue[800],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=3',
                    ),
                  ),
                  Text(
                    userModel.nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_2_rounded),
              title: const Text('Edit Profile'),
              onTap: () {
                // Handle home navigation

                Navigator.pop(context); // Close the drawer
                _showEditProfileModal(context, userModel);
                // show modal bottom sheet to edit profile
              },
            ),
            // Add more list items as needed
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $nama!",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
                const Text(
                  "Let's start your day with a positive motivation!",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _motivationController,
              autofocus: false,
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                labelText: 'Motivation',
                hintText: 'What is your motivation today?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
                onPressed: () {
                  _saveMotivation();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue[800],
                  onPrimary: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Save')),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Your Motivation',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    MotivationService.getMotivationByIduser(
                        userModel.iduser ?? "");
                  });
                },
                child: FutureBuilder<List<MotivationModel>>(
                    future: MotivationService.getMotivationByIduser(
                        userModel.iduser ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else if (snapshot.data?.isEmpty ?? true) {
                        return const Center(
                          child: Text('No Data'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                  title: Text(
                                      snapshot.data?[index].isiMotivasi ?? ""),
                                  subtitle: Text(
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      snapshot.data?[index].tanggalInput
                                              .toString() ??
                                          ""),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          MotivationService.deleteMotivation(
                                              snapshot.data?[index].id ?? "");
                                          setState(() {
                                            MotivationService
                                                .getMotivationByIduser(
                                                    userModel.iduser ?? "");
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showEditMotivationModal(
                                              context,
                                              snapshot.data?[index].id ?? "",
                                              snapshot.data?[index]
                                                      .isiMotivasi ??
                                                  "");
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.lightBlue[900],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveMotivation() async {
    print(_motivationController.text);
    if (_motivationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Motivation cannot be empty'),
        ),
      );
      return;
    }
    EasyLoading.show(status: 'saving...');

    MotivationModel motivation = MotivationModel(
      iduser: userModel.iduser ?? "1",
      isiMotivasi: _motivationController.text,
    );
    bool added = await MotivationService.createMotivation(motivation);
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Motivation added'),
        ),
      );
      setState(() {
        MotivationService.getMotivationByIduser(userModel.iduser ?? "");
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add motivation'),
        ),
      );
    }
    _motivationController.clear();
    FocusScope.of(context).unfocus();
    EasyLoading.dismiss();
  }

  void _showEditMotivationModal(
      BuildContext context, String idMotivasi, String isiMotivasi) {
    TextEditingController _editMotivation =
        TextEditingController(text: isiMotivasi);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter new motivation here',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _editMotivation,
                decoration: const InputDecoration(
                  hintText: 'Write new motivation',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  MotivationModel motivation = MotivationModel(
                    id: idMotivasi,
                    iduser: userModel.iduser ?? "1",
                    isiMotivasi: _editMotivation.text,
                  );
                  if (_editMotivation.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Motivation cannot be empty'),
                      ),
                    );
                    return;
                  }
                  EasyLoading.show(status: 'updating...');
                  Navigator.pop(context); // Close the modal
                  bool isUpdated =
                      await MotivationService.updateMotivation(motivation);
                  if (isUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Motivation updated'),
                      ),
                    );
                    setState(() {
                      MotivationService.getMotivationByIduser(
                          userModel.iduser ?? "");
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to update motivation'),
                      ),
                    );
                  }
                  EasyLoading.dismiss();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue[800],
                    onPrimary: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProfileModal(BuildContext context, UserModel user) {
    final TextEditingController _namaController = TextEditingController(text: user.nama);
    final TextEditingController _emailController = TextEditingController(text: user.email);
    final TextEditingController _profesiController = TextEditingController(text: user.profesi);
    final TextEditingController _passwordController = TextEditingController();


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 16.0),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  label: Text('Nama'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _profesiController,
                decoration: const InputDecoration(
                  hintText: 'Profession',
                  label: Text('Profession'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'New Password',
                  label: Text('New Password'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  UserModel _userModel = UserModel(
                    iduser: user.iduser,
                    nama: _namaController.text,
                    email: _emailController.text,
                    profesi: _profesiController.text,
                    password: _passwordController.text,
                  );
                  if (_namaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Name cannot be empty'),
                      ),
                    );
                    return;
                  }
                  EasyLoading.show(status: 'updating...');
                  Navigator.pop(context); // Close the modal
                  bool isUpdated =
                      await UserService.editProfile(_userModel);
                  if (isUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated'),
                      ),
                    );

                    UserModel? newUser = await UserService.getUserById(user.iduser ?? "");
                    setState(() {
                      userModel.nama = newUser?.nama ?? "";
                      userModel.email = newUser?.email ?? "";
                      userModel.profesi = newUser?.profesi ?? "";
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to update profile'),
                      ),
                    );
                  }
                  EasyLoading.dismiss();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue[800],
                    onPrimary: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: const Text('Update Profile Info'),
              ),
            ],
          ),
        );
      },
    );
  }
}
