import 'package:flutter/material.dart';
import 'package:myapp/Service/userService.dart';
import 'package:myapp/model/user.dart';



class Add extends StatefulWidget {
  @override
  _UsuarioListScreenState createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<Add> {
  final _personService = UsuarioService();
  late Future<List<Usuario>> _personsFuture;

  @override
  void initState() {
    super.initState();
    _personsFuture = _personService.fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons'),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: _personsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final persons = snapshot.data!;
            return ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                final person = persons[index];
                return ListTile(
                  title: Text('${person.dni} ${person.name} ${person.lastname}'),
                  subtitle: Text(person.details),

                  onTap: () {
                    // Handle tapping on the person item
                    _showPersonDialog(person);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Handle adding a new person
          _showPersonDialog(null);
        },
      ),
    );
  }

  Future<void> _showPersonDialog(Usuario? person) async {
    final isEditing = person != null;
    final title = isEditing ? 'Edit Person' : 'Add Person';
    final TextEditingController nameController =
    TextEditingController(text: person?.name);
    final TextEditingController lastnameController =
    TextEditingController(text: person?.lastname);
    final TextEditingController emailController =
    TextEditingController(text: person?.email);
    final TextEditingController detailsController =
    TextEditingController(text: person?.details);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(labelText: 'Lastname'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(labelText: 'details'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isEditing ? 'Update' : 'Add'),
              onPressed: () {
                final newPerson = Usuario(
                  dni: person?.dni ?? 0,
                  name: nameController.text,
                  lastname: lastnameController.text,
                  email: emailController.text,
                  details: detailsController.text,
                );

                if (isEditing) {
                  // Handle updating the person
                  _updatePerson(newPerson);
                } else {
                  // Handle adding a new person
                  _addPerson(newPerson);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addPerson(Usuario person) async {
    // Handle adding a new person
    try {
      await _personService.createPerson(person);
      // Refresh the list of persons
      setState(() {
        _personsFuture = _personService.fetchPersons();
      });
    } catch (e) {
      // Handle error
      print('Error adding person: $e');
    }
  }

  Future<void> _updatePerson(Usuario person) async {
    // Handle updating the person
    try {
      await _personService.updatePerson(person);
      // Refresh the list of persons
      setState(() {
        _personsFuture = _personService.fetchPersons();
      });
    } catch (e) {
      // Handle error
      print('Error updating person: $e');
    }
  }
}