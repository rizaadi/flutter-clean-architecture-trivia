import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:trivia_clean_architecture/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (context) => sl<NumberTriviaBloc>(),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            const SizedBox(height: 10),
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Center(child: Text('Start searching!')),
                  );
                } else if (state is Loading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is Loaded) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      children: [
                        Text('${state.trivia.number}'),
                        Expanded(
                            child: Center(
                          child: SingleChildScrollView(child: Text(state.trivia.text)),
                        ))
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 20),
            const TriviaControl(),
          ]),
        )),
      )),
    );
  }
}

class TriviaControl extends StatefulWidget {
  const TriviaControl({
    super.key,
  });

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  final controller = TextEditingController();
  String inputStr = '';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input a number',
        ),
        onChanged: (value) {
          inputStr = value;
        },
        onSubmitted: (value) {},
      ),
      const SizedBox(height: 20),
      Row(children: [
        Expanded(
            child: ElevatedButton(
          onPressed: addConcrete,
          child: const Text("Search"),
        )),
        Expanded(
            child: ElevatedButton(
          onPressed: addRandom,
          child: const Text("Get Random Trivia"),
        ))
      ]),
    ]);
  }

  void addConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForConcreteNumber(inputStr));
  }

  void addRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
