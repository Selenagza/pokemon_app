import 'package:flutter/material.dart';
import 'package:pokemon_app/pokemon.dart';
import 'package:pokemon_app/pokemon_fetch.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late final Future<List<Pokemon>> futurePokemon;

  @override
  void initState() {
    super.initState();

    futurePokemon = fetchListOfPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon App"),
      ),
      body: FutureBuilder(
        future: futurePokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var pokemons = snapshot.data!;

            return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(pokemons[index].name),
                    ),
                separatorBuilder: ((_, __) => const SizedBox(
                      height: 8,
                    )),
                itemCount: pokemons.length);
          }
          if (snapshot.hasError) {
            return Text("Oops an error happened: ${snapshot.error}");
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
