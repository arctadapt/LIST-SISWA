import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aplikasi Data Siswa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNameControllerCreate = TextEditingController();
  final TextEditingController _lastNameControllerCreate = TextEditingController();
  
  final TextEditingController _firstNameControllerUpdate = TextEditingController();
  final TextEditingController _lastNameControllerUpdate = TextEditingController();

  // Dropdown values
  final List<String> _classes = ['X', 'XI', 'XII'];
  final List<String> _majors = ['PPLG', 'MPLB', 'DKV', 'HR', 'TJKT', 'TM', 'TKR', 'TSM'];

  String? _selectedClassCreate;
  String? _selectedMajorCreate;

  String? _selectedClassUpdate;
  String? _selectedMajorUpdate;

  List<Map<String, String>> _students = [];

  void _addStudent() {
    if (_firstNameControllerCreate.text.isEmpty ||
        _lastNameControllerCreate.text.isEmpty ||
        _selectedClassCreate == null ||
        _selectedMajorCreate == null) {
      // Tampilkan pesan validasi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua form sebelum mengirim!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _students.add({
        'firstName': _firstNameControllerCreate.text,
        'lastName': _lastNameControllerCreate.text,
        'class': _selectedClassCreate!,
        'major': _selectedMajorCreate!,
      });
      _firstNameControllerCreate.clear();
      _lastNameControllerCreate.clear();
      _selectedClassCreate = null;
      _selectedMajorCreate = null;
    });

    // Tampilkan pesan sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil ditambahkan!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showEditBottomSheet(int index) {
    _firstNameControllerUpdate.text = _students[index]['firstName']!;
    _lastNameControllerUpdate.text = _students[index]['lastName']!;
    _selectedClassUpdate = _students[index]['class'];
    _selectedMajorUpdate = _students[index]['major'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Data Siswa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _firstNameControllerUpdate,
                decoration: const InputDecoration(hintText: "First Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameControllerUpdate,
                decoration: const InputDecoration(hintText: "Last Name"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedClassUpdate,
                items: _classes
                    .map((classItem) =>
                        DropdownMenuItem(value: classItem, child: Text(classItem)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClassUpdate = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Class"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedMajorUpdate,
                items: _majors
                    .map((majorItem) =>
                        DropdownMenuItem(value: majorItem, child: Text(majorItem)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMajorUpdate = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Major"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_firstNameControllerUpdate.text.isEmpty ||
                      _lastNameControllerUpdate.text.isEmpty ||
                      _selectedClassUpdate == null ||
                      _selectedMajorUpdate == null) {
                    // Tampilkan pesan validasi jika form tidak lengkap
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Harap isi semua form sebelum update!'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    _students[index] = {
                      'firstName': _firstNameControllerUpdate.text,
                      'lastName': _lastNameControllerUpdate.text,
                      'class': _selectedClassUpdate!,
                      'major': _selectedMajorUpdate!,
                    };
                    _firstNameControllerUpdate.clear();
                    _lastNameControllerUpdate.clear();
                    _selectedClassUpdate = null;
                    _selectedMajorUpdate = null;
                  });

                  // Tampilkan pesan sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil diperbarui!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteStudent(int index) {
    setState(() {
      _students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil dihapus!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _firstNameControllerCreate,
              decoration: const InputDecoration(hintText: "First Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _lastNameControllerCreate,
              decoration: const InputDecoration(hintText: "Last Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButtonFormField<String>(
              value: _selectedClassCreate,
              items: _classes
                  .map((classItem) =>
                      DropdownMenuItem(value: classItem, child: Text(classItem)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedClassCreate = value;
                });
              },
              decoration: const InputDecoration(labelText: "Class"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButtonFormField<String>(
              value: _selectedMajorCreate,
              items: _majors
                  .map((majorItem) =>
                      DropdownMenuItem(value: majorItem, child: Text(majorItem)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMajorCreate = value;
                });
              },
              decoration: const InputDecoration(labelText: "Major"),
            ),
          ),
          ElevatedButton(
            onPressed: _addStudent,
            child: const Text('Kirim'),
          ),
          const Divider(),  // Pembatas antara form dan list data
          Expanded(
            child: _students.isEmpty
                ? const Center(child: Text('Data tidak ada'))
                : ListView.builder(
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          title: Text(
                              "${_students[index]['firstName']} ${_students[index]['lastName']}"),
                          subtitle: Text(
                              "${_students[index]['class']} ${_students[index]['major']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _showEditBottomSheet(index),
                                icon: const Icon(Icons.edit, color: Colors.blue),
                              ),
                              IconButton(
                                onPressed: () => _deleteStudent(index),
                                icon: const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}