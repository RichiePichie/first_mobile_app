import 'package:bloc/bloc.dart';
import 'package:first_mobile_app/calculator/cubit/calculator_state.dart';
import 'package:intl/intl.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorState());

  String _firstOperand = '';
  String _operator = '';
  String _secondOperand = '';
  bool _shouldResetDisplay = false;

  final _formatter = NumberFormat.decimalPattern('en_us');

  void onButtonPressed(String value) {
    if (double.tryParse(value) != null || value == '.') {
      _handleNumberInput(value);
    } else {
      _handleOperatorInput(value);
    }
  }

  void _handleNumberInput(String number) {
    if (_shouldResetDisplay) {
      emit(state.copyWith(display: '0'));
      _shouldResetDisplay = false;
    }

    if (number == '.' && state.display.contains('.')) return;

    if (state.display == '0' && number != '.') {
      emit(state.copyWith(display: number));
    } else {
      emit(state.copyWith(display: state.display + number));
    }
  }

  void _handleOperatorInput(String operator) {
    switch (operator) {
      case 'C':
        _clear();
        break;
      case '±':
        _toggleSign();
        break;
      case '%':
        _calculatePercentage();
        break;
      case '=':
        _calculateResult();
        break;
      default:
        _setOperator(operator);
        break;
    }
  }

  void _clear() {
    _firstOperand = '';
    _operator = '';
    _secondOperand = '';
    emit(const CalculatorState());
  }

  void _toggleSign() {
    if (state.display == '0') return;
    final currentValue = double.parse(state.display);
    emit(state.copyWith(display: _formatResult(-currentValue)));
  }

  void _calculatePercentage() {
    if (state.display == '0') return;
    final currentValue = double.parse(state.display);
    emit(state.copyWith(display: _formatResult(currentValue / 100)));
  }

  void _setOperator(String newOperator) {
    if (_firstOperand.isEmpty) {
      _firstOperand = state.display;
      _operator = newOperator;
      _shouldResetDisplay = true;
    } else {
      _calculateResult();
      _operator = newOperator;
      _shouldResetDisplay = true;
    }
  }

  void _calculateResult() {
    if (_firstOperand.isEmpty || _operator.isEmpty) return;

    _secondOperand = state.display;

    final firstNum = double.parse(_firstOperand);
    final secondNum = double.parse(_secondOperand);
    double result = 0;

    switch (_operator) {
      case '÷':
        result = firstNum / secondNum;
        break;
      case '×':
        result = firstNum * secondNum;
        break;
      case '−':
        result = firstNum - secondNum;
        break;
      case '+':
        result = firstNum + secondNum;
        break;
    }

    emit(state.copyWith(display: _formatResult(result)));
    _firstOperand = result.toString();
    _operator = '';
    _secondOperand = '';
    _shouldResetDisplay = true;
  }

  String _formatResult(double result) {
    if (result == result.truncate()) {
      return result.truncate().toString();
    } else {
      return _formatter.format(result);
    }
  }
}
