import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_app/pokemon.dart';

const baseUrl = "https://pokeapi.co/api/v2/pokemon";

Future<List<Pokemon>> fetchListOfPokemon() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));
    final requestSuccessful = response.statusCode == 200;

    if (requestSuccessful) {
      var pokemonsJson = jsonDecode(response.body)["results"] as List<dynamic>;

      return pokemonsJson.map((pokemonJson) {
        return Pokemon(name: pokemonJson["name"], url: pokemonJson["url"]);
      }).toList();
    }

    return [];
  } catch (exception) {
    print(exception);
    return [];
  }
}
