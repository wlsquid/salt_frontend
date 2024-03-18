import 'package:flutter/material.dart';
import 'package:salt/screens/address_data_list.dart';

class AddressListsScreen extends StatefulWidget {
  const AddressListsScreen({super.key});

  @override
  State<AddressListsScreen> createState() => _AddressListsScreenState();
}

class _AddressListsScreenState extends State<AddressListsScreen> {
  List<Map> testData = [
    {
      'id' : 1,
      'name' : 'address list 1',
      'addressCount': 50,
    },
    {
      'id' : 2,
      'name' : 'address list 2',
      'addressCount': 40,
    },
    {
      'id' : 3,
      'name' : 'address list 3',
      'addressCount': 30,
    },
    {
      'id' : 4,
      'name' : 'address list 4',
      'addressCount': 20,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Chose a doorknock list'),
      ),
      body: ListView.separated(
          itemCount: testData.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = testData[index];

            return ListTile(
              title: Text(item["name"], style: Theme.of(context).textTheme.headlineSmall,),
              subtitle: Text('No. of Addresses: ${item["addressCount"].toString()}', style: Theme.of(context).textTheme.labelSmall,),
              trailing: const Icon(Icons.holiday_village),
              //shape: const Border(bottom: BorderSide(color: Colors.black, width: 1)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const AddressDataList();
                    },));
              },
            );
          },
        ),
    );
  }
}