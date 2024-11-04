import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TipMate - The #1 Tip Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212), // AppBar background color
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.raleway(
            color: Colors.white,
          ),
          titleMedium: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 35, // Adjusted font size for header
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      home: const TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final TextEditingController _billController = TextEditingController();
  double _tipAmount = 0.0;
  double _tipPercentage = 15.0;
  double _totalAmount = 0.0; // Variable to hold the total amount
  int _numberOfPeople = 1; // Variable for the number of people splitting the bill

  void _calculateTip() {
    final double billAmount = double.tryParse(_billController.text) ?? 0.0;
    setState(() {
      _tipAmount = billAmount * (_tipPercentage / 100);
      _totalAmount = billAmount + _tipAmount; // Calculate total amount
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Adjust height as needed
        child: AppBar(
          backgroundColor: const Color(0xFF121212), // AppBar background color
          title: Container(
            alignment: Alignment.center, // Centers the text vertically
            height: 50.0, // Set height to give space above and below the text
            child: Text(
              'TipMate - Tip App',
              style: GoogleFonts.montserrat(
                fontSize: 40, // Font size
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0), // Removed vertical padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align content at the start
          children: <Widget>[
            TextField(
              controller: _billController,
              decoration: const InputDecoration(
                labelText: 'Enter Total Bill Here:',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tip Percentage: ${_tipPercentage.toStringAsFixed(0)}%',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _tipPercentage,
                    min: 0,
                    max: 45,
                    label: '${_tipPercentage.toStringAsFixed(0)}%',
                    activeColor: Colors.grey[300],
                    inactiveColor: Colors.grey[600],
                    onChanged: (double value) {
                      setState(() {
                        _tipPercentage = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTip,
              child: Text(
                'Calculate Tip',
                style: GoogleFonts.raleway(), // Default style for button text
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tip Amount: \$${_tipAmount.toStringAsFixed(2)}',
              style: GoogleFonts.raleway(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Text(
              'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
              style: GoogleFonts.raleway(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // New Slider for splitting the bill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Split: $_numberOfPeople',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _numberOfPeople.toDouble(),
                    min: 1,
                    max: 30,
                    label: '$_numberOfPeople',
                    activeColor: Colors.grey[300],
                    inactiveColor: Colors.grey[600],
                    onChanged: (double value) {
                      setState(() {
                        _numberOfPeople = value.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Display split cost per person
            Text(
              'Split Cost: \$${((_totalAmount) / _numberOfPeople).toStringAsFixed(2)} ',
              style: GoogleFonts.raleway(
                fontSize: 24,
                color: Colors.white,
              ),
            ),

            // Display split tip amount per person
            Text(
              'Split Tip: \$${(_tipAmount / _numberOfPeople).toStringAsFixed(2)}',
              style: GoogleFonts.raleway(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
