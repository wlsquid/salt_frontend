import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:salt/screens/address_data_form.dart';

class AddressDataList extends StatefulWidget {
  const AddressDataList({super.key});

  @override
  State<AddressDataList> createState() => _AddressDataListState();
}

class _AddressDataListState extends State<AddressDataList> {
  final List<Map> testData = [
    {
        "id": 1,
        "address_list_id": 1,
        "address": "123 fuck off street",
        "postcode": 4000,
        "name": "Fred",
        "contact_phone": "+6145976783",
        "landlord": "FUCKWIT",
        "issues": "ajfhjkadhfjkshajk",
        "support_level_id": 5,
        "support_level_explanation": "djkalsjdkljaskldskaldjkasjdkljaskjdkajsdaskldjklasj",
        "interested_in": "Meetings",
        "created_at": "2024-03-17T23:39:00.000000Z",
        "updated_at": "2024-03-17T23:44:14.000000Z",
        "archived": 0,
        "address_visits": [
            {
                "id": 2,
                "address_data_id": 1,
                "doorknock_response_id": 2,
                "response_explanation": "told us to fuck off",
                "user_id": 1,
                "created_at": "2024-03-18T00:11:16.000000Z",
                "updated_at": "2024-03-18T00:11:16.000000Z"
            },
            {
                "id": 1,
                "address_data_id": 1,
                "doorknock_response_id": 2,
                "response_explanation": "Answered",
                "user_id": 1,
                "created_at": "2024-03-18T00:11:05.000000Z",
                "updated_at": "2024-03-18T00:11:05.000000Z"
            }
        ]
    },
    {
        "id": 2,
        "address_list_id": 1,
        "address": "656 goaway avenue",
        "postcode": 4100,
        "name": null,
        "contact_phone": null,
        "landlord": null,
        "issues": null,
        "support_level_id": null,
        "support_level_explanation": null,
        "interested_in": null,
        "created_at": "2024-03-17T23:39:00.000000Z",
        "updated_at": "2024-03-17T23:39:00.000000Z",
        "archived": 0,
        "address_visits": []
    },
    {
        "id": 3,
        "address_list_id": 1,
        "address": "767 yes street",
        "postcode": 4111,
        "name": null,
        "contact_phone": null,
        "landlord": null,
        "issues": null,
        "support_level_id": null,
        "support_level_explanation": null,
        "interested_in": null,
        "created_at": "2024-03-17T23:39:00.000000Z",
        "updated_at": "2024-03-17T23:39:00.000000Z",
        "archived": 0,
        "address_visits": []
    }
  ];

  List<Map> searchData = [];
  TextEditingController _editingController = TextEditingController();
  
  @override
  void initState() {
    searchData = testData;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      // select data that has same postcode or address
      searchData = testData
          .where(
            (item) => item["address"].toLowerCase().contains(query.toLowerCase()) 
          || item["postcode"].toString().toLowerCase().contains(query.toLowerCase())
          ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tap To Visit & Enter Notes'),
      ),
      body:  
        // Need to add a search function
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: _editingController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
                itemCount: searchData.length,
                itemBuilder: (context, index) {
                  final item = searchData[index];
                  String latestVisit = 'Not Yet Doorknocked';            
                  List addressVisits = item['address_visits'];
                  String rating = '?';
            
                  if (addressVisits.isNotEmpty) {
                    final Map firstVisit = addressVisits[0];
                    final DateTime timeVisited = DateTime.parse(firstVisit['created_at']);
                    initializeDateFormatting();
                    final DateFormat dateDisplay = DateFormat.yMd('en_AU');
            
                    latestVisit = dateDisplay.format(timeVisited);
                    rating = firstVisit['doorknock_response_id'].toString();
                  }
            
                  return ListTile(
                    title: Text(item["address"], style: Theme.of(context).textTheme.headlineSmall,),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Visited: $latestVisit | rated: $rating', style: Theme.of(context).textTheme.labelSmall,),
                        if (addressVisits.isNotEmpty) ElevatedButton(
                          style: ElevatedButton.styleFrom(side: BorderSide(color: Theme.of(context).primaryColor)),
                          onPressed: () {
                          
                          },
                          child: const Text('View Visits'),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Postcode:\n${item["postcode"].toString()}', style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center,),
                        const Icon(Icons.chevron_right)
                        // SafeArea(
                        //   child: TextButton(
                        //     style: TextButton.styleFrom(side: BorderSide(color: Theme.of(context).primaryColor)),
                        //     onPressed: () {
                            
                        //     },
                        //     child: const Text('Start'),
                        //   ),
                        // ),
                      ],
                    ),
                    
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const AddressDataForm();
                      },));
                    },
                  );
                },
              ),
          )
          ],
      ),
    );
  }
}