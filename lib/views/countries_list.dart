import 'package:covidtracker/Services/fetchworldstate.dart';
import 'package:covidtracker/views/specific_country.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController search = TextEditingController();
  late String name;
  WorldStates stateservice = WorldStates();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.2),
        title: const Text('Countries'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: search,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                fillColor: Colors.deepPurple.withOpacity(0.2),
                filled: true,
                hintText: 'Search a Country',
                prefixIcon: Icon(Icons.search),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        search.text = '';
                      });
                    },
                    child: const Icon(Icons.close)),
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.tealAccent.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateservice.fetchcountriesdata(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                // print(snapshot);
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      name = snapshot.data![index]['country'];

                      if (search.text.isEmpty) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SpecificCountry(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        cases: snapshot.data![index]['cases'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        death: snapshot.data![index]['deaths'],
                                        recovered: snapshot.data![index]
                                            ['recovered'],
                                        todayrec: snapshot.data![index]
                                            ['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                        active: snapshot.data![index]['active'],
                                      ),
                                    ));
                              },
                              style: ListTileStyle.list,
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image(
                                    image: NetworkImage(snapshot.data![index]
                                            ['countryInfo']['flag']
                                        .toString())),
                              ),
                              title: Text(
                                snapshot.data![index]['country'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(search.text.toLowerCase())) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SpecificCountry(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        cases: snapshot.data![index]['cases'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        death: snapshot.data![index]['deaths'],
                                        recovered: snapshot.data![index]
                                            ['recovered'],
                                        todayrec: snapshot.data![index]
                                            ['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                        active: snapshot.data![index]['active'],
                                      ),
                                    ));
                              },
                              style: ListTileStyle.list,
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image(
                                    image: NetworkImage(snapshot.data![index]
                                            ['countryInfo']['flag']
                                        .toString())),
                              ),
                              title: Text(
                                snapshot.data![index]['country'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
