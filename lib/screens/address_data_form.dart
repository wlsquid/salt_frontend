import 'package:flutter/material.dart';

class AddressDataForm extends StatefulWidget {
  const AddressDataForm({super.key});

  @override
  State<AddressDataForm> createState() => _AddressDataFormState();
}

class _AddressDataFormState extends State<AddressDataForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _landlordController = TextEditingController();
  final TextEditingController _issuesController = TextEditingController();
  final TextEditingController _supportLevelExplanationController = TextEditingController();  
  final TextEditingController _responseController = TextEditingController(text:'See issues');  
  int? supportLevel;
  int? responseLevel;
  bool _meetings = false;
  bool _training = false;
  bool _campaign = false;
  int? _responseEditId;

  Map<String, int> supportLevels = 
    {'Hostile' : 1,
    'Neutral (no issues)' : 2,
    'Interested But Hesitant' : 3,
    'Interested But Has Some Barriers' : 4,
    'Keen to get involved' : 5,};

  Map<String, int> responseTypes = 
    {'Meaningful':1,
     'No Answer':2,
     'Busy':3,
     'Not Interested':4,
     'Inaccessible':5, 
     'Bad Info':6, 
     'Refused':7
    };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Enter Notes'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(        
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Container(
                padding: const EdgeInsets.all(8),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(2),child:Text('Visit Details', 
                    style: Theme.of(context).textTheme.headlineMedium,
                    )),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Short explantion if not meaningful',
                      ),
                      maxLines: 4,
                      controller: _responseController,
                    ),
                    DropdownButton<int>(
                      value: responseLevel,
                      isExpanded: true,
                      hint: const Text('Meaningful or?', style: TextStyle(fontSize: 18),),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (int? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          responseLevel = value!;
                        });
                      },
                      items: responseTypes.entries.map<DropdownMenuItem<int>>((value) {
                        return DropdownMenuItem<int>(
                          value: value.value,
                          child: Text(value.key, style: const TextStyle(fontSize: 18),),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          //   return const AddressListsScreen();
                          // },));
                        },
                        child: Text(_responseEditId == null ? 'Submit' : 'Submit Changes'),
                      ),
                    ),
                    ],
                ),
              ),
              const SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.all(8),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(2),child:Text('Enter Details', 
                    style: Theme.of(context).textTheme.headlineMedium,
                    )),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Name',
                      ),
                      controller: _nameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone_android),
                        labelText: 'Phone/Contact',
                      ),
                      controller: _phoneController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.thumb_down),
                        labelText: 'Landlord/Real Estate',
                      ),
                      controller: _landlordController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.edit_document),
                        labelText: 'Issues + Notes',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                        )
                      ),
                      maxLines: 10,
                      controller: _issuesController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text('Support Level', style: Theme.of(context).textTheme.bodyLarge,),
                    ),
                    DropdownButton<int>(
                      value: supportLevel,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (int? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          supportLevel = value!;
                        });
                      },
                      items: supportLevels.entries.map<DropdownMenuItem<int>>((value) {
                        return DropdownMenuItem<int>(
                          value: value.value,
                          child: Text('${value.key} - ${value.value}',style: const TextStyle(fontSize: 18),),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        //icon: Icon(Icons.diversity_1),
                        labelText: 'Why This Support Level?',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                        )
                      ),
                      maxLines: 4,
                      controller: _supportLevelExplanationController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text('Interested In', style: Theme.of(context).textTheme.bodyLarge,),
                    ),
                    ListTile(
                      leading: Text('Meetings', style: Theme.of(context).textTheme.bodyMedium,),
                      trailing: Checkbox(
                        
                        // checkColor: Colors.deepOrange,
                        // fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: _meetings,
                        onChanged: (bool? value) {
                          setState(() {
                            _meetings = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: Text('Training', style: Theme.of(context).textTheme.bodyMedium,),
                      trailing: Checkbox(
                        
                        // checkColor: Colors.deepOrange,
                        // fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: _training,
                        onChanged: (bool? value) {
                          setState(() {
                            _training = value!;
                          });
                        },
                      ),
                    ),          
                    ListTile(
                      leading: Text('Campaign', style: Theme.of(context).textTheme.bodyMedium,),
                      trailing: Checkbox(
                        
                        // checkColor: Colors.deepOrange,
                        // fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: _campaign,
                        onChanged: (bool? value) {
                          setState(() {
                            _campaign = value!;
                          });
                        },
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          //   return const AddressListsScreen();
                          // },));
                        },
                        child: const Text('Submit Data'),
                      ),
                    ),
                ],
                ),
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}