import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_mobile_app/calculator/cubit/calculator_cubit.dart';
import 'package:first_mobile_app/calculator/cubit/calculator_state.dart';
import 'package:first_mobile_app/calculator/widgets/calculator_button.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorCubit(),
      child: const CalculatorView(),
    );
  }
}

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<CalculatorCubit, CalculatorState>(
              builder: (context, state) {
                return Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  child: Text(
                    state.display,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 96,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
            const ButtonGrid(),
          ],
        ),
      ),
    );
  }
}

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalculatorCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(
                label: 'C',
                onPressed: () => cubit.onButtonPressed('C'),
                backgroundColor: const Color(0xFFA5A5A5),
                foregroundColor: Colors.black,
              ),
              CalculatorButton(
                label: '±',
                onPressed: () => cubit.onButtonPressed('±'),
                backgroundColor: const Color(0xFFA5A5A5),
                foregroundColor: Colors.black,
              ),
              CalculatorButton(
                label: '%',
                onPressed: () => cubit.onButtonPressed('%'),
                backgroundColor: const Color(0xFFA5A5A5),
                foregroundColor: Colors.black,
              ),
              CalculatorButton(
                label: '÷',
                onPressed: () => cubit.onButtonPressed('÷'),
                backgroundColor: const Color(0xFFFF9F0A),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(
                label: '7',
                onPressed: () => cubit.onButtonPressed('7'),
              ),
              CalculatorButton(
                label: '8',
                onPressed: () => cubit.onButtonPressed('8'),
              ),
              CalculatorButton(
                label: '9',
                onPressed: () => cubit.onButtonPressed('9'),
              ),
              CalculatorButton(
                label: '×',
                onPressed: () => cubit.onButtonPressed('×'),
                backgroundColor: const Color(0xFFFF9F0A),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(
                label: '4',
                onPressed: () => cubit.onButtonPressed('4'),
              ),
              CalculatorButton(
                label: '5',
                onPressed: () => cubit.onButtonPressed('5'),
              ),
              CalculatorButton(
                label: '6',
                onPressed: () => cubit.onButtonPressed('6'),
              ),
              CalculatorButton(
                label: '−',
                onPressed: () => cubit.onButtonPressed('−'),
                backgroundColor: const Color(0xFFFF9F0A),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(
                label: '1',
                onPressed: () => cubit.onButtonPressed('1'),
              ),
              CalculatorButton(
                label: '2',
                onPressed: () => cubit.onButtonPressed('2'),
              ),
              CalculatorButton(
                label: '3',
                onPressed: () => cubit.onButtonPressed('3'),
              ),
              CalculatorButton(
                label: '+',
                onPressed: () => cubit.onButtonPressed('+'),
                backgroundColor: const Color(0xFFFF9F0A),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(
                label: '0',
                onPressed: () => cubit.onButtonPressed('0'),
                width: 176,
              ),
              CalculatorButton(
                label: '.',
                onPressed: () => cubit.onButtonPressed('.'),
              ),
              CalculatorButton(
                label: '=',
                onPressed: () => cubit.onButtonPressed('='),
                backgroundColor: const Color(0xFFFF9F0A),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
