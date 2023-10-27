import 'dart:convert' show jsonDecode;

import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/detalhe_pokemon.dart';
import 'package:pokedex/main.dart';

class TelaInicio extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  var pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List? pokedex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      pegarDataPokemon();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: -50,
          right: -50,
          child: Image.asset(
            'assets/images/pokeball.png',
            width: 200,
            fit: BoxFit.fitWidth,
          )),
      Positioned(
          top: 80,
          left: 20,
          child: Text(
            "Pokedex",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
      Positioned(
        top: 150,
        bottom: 0,
        width: width,
        child: Column(
          children: [
            pokedex != null
                ? Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: pokedex?.length,
                        itemBuilder: (context, index) {
                          var type = pokedex?[index]['type'][0];
                          var id = pokedex?[index]['id'];
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: type == 'Grass'
                                      ? Color.fromARGB(255, 76, 206, 141)
                                      : type == 'Fire'
                                          ? Color.fromARGB(255, 206, 128, 76)
                                          : type == 'Water'
                                              ? Color.fromARGB(
                                                  255, 76, 154, 206)
                                              : type == 'Electric'
                                                  ? Color.fromARGB(
                                                      255, 224, 223, 118)
                                                  : type == 'Rock'
                                                      ? Colors.grey
                                                      : type == 'Ground'
                                                          ? Colors.brown
                                                          : type == 'Psychic'
                                                              ? Colors.purple
                                                                  .shade300
                                                              : type ==
                                                                      'Fighting'
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          170,
                                                                          124,
                                                                          39)
                                                                  : type ==
                                                                          'Bug'
                                                                      ? const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          154,
                                                                          201,
                                                                          101)
                                                                      : type ==
                                                                              'Ghost'
                                                                          ? Colors
                                                                              .deepPurple
                                                                          : type == 'Normal'
                                                                              ? Colors.blueGrey
                                                                              : type == 'Poison'
                                                                                  ? Color.fromARGB(255, 129, 88, 241)
                                                                                  : type == 'Ice'
                                                                                      ? Color.fromARGB(255, 149, 209, 233)
                                                                                      : type == 'Dragon'
                                                                                          ? Color.fromARGB(255, 44, 65, 92)
                                                                                          : Colors.pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Stack(children: [
                                  Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'assets/images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Positioned(
                                      top: 20,
                                      left: 10,
                                      child: Text(pokedex?[index]['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white))),
                                  Positioned(
                                    top: 45,
                                    left: 20,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            top: 4,
                                            bottom: 4),
                                        child: Text(
                                          type.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 20,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            top: 4,
                                            bottom: 4),
                                        child: Text(
                                          id.toString(),
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: CachedNetworkImage(
                                      imageUrl: pokedex?[index]['img'],
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            onTap: () {
                              //Aqui a gente navega até nova tela
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetalhePokemon(
                                            pokemonDetail: pokedex?[index],
                                            color: type == 'Grass'
                                                ? Color.fromARGB(
                                                    255, 76, 206, 141)
                                                : type == 'Fire'
                                                    ? Color.fromARGB(
                                                        255, 206, 128, 76)
                                                    : type == 'Water'
                                                        ? Color.fromARGB(
                                                            255, 76, 154, 206)
                                                        : type == 'Electric'
                                                            ? Color.fromARGB(
                                                                255,
                                                                224,
                                                                223,
                                                                118)
                                                            : type == 'Rock'
                                                                ? Colors.grey
                                                                : type ==
                                                                        'Ground'
                                                                    ? Colors
                                                                        .brown
                                                                    : type ==
                                                                            'Psychic'
                                                                        ? Colors
                                                                            .purple
                                                                            .shade300
                                                                        : type ==
                                                                                'Fighting'
                                                                            ? Color.fromARGB(
                                                                                255,
                                                                                170,
                                                                                124,
                                                                                39)
                                                                            : type == 'Bug'
                                                                                ? const Color.fromARGB(255, 154, 201, 101)
                                                                                : type == 'Ghost'
                                                                                    ? Colors.deepPurple
                                                                                    : type == 'Normal'
                                                                                        ? Colors.blueGrey
                                                                                        : type == 'Poison'
                                                                                            ? Color.fromARGB(255, 129, 88, 241)
                                                                                            : type == 'Ice'
                                                                                                ? Color.fromARGB(255, 149, 209, 233)
                                                                                                : type == 'Dragon'
                                                                                                    ? Color.fromARGB(255, 44, 65, 92)
                                                                                                    : Colors.pink,
                                            heroTag: index,
                                          )));
                            },
                          );
                        }))
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
      ),
    ]));
  }

  void pegarDataPokemon() {
    var url = Uri.https('raw.githubusercontent.com',
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        print(pokedex?[100]['name']);
        setState(() {});
      }
    });
  }
}
