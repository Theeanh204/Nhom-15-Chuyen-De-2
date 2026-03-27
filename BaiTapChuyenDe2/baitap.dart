import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máy tính lãi suất',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const InterestCalculatorScreen(),
    );
  }
}

class InterestCalculatorScreen extends StatefulWidget {
  const InterestCalculatorScreen({super.key});

  @override
  State<InterestCalculatorScreen> createState() => _InterestCalculatorScreenState();
}

class _InterestCalculatorScreenState extends State<InterestCalculatorScreen> {
  final _soTienController = TextEditingController();
  final _laiController = TextEditingController();
  final _soNamController = TextEditingController();   // vẫn giữ để tính lãi theo số năm

  String _loaiLai = 'Lãi suất đơn';
  String _ketQua = '';

  void _tinhToan() {
    final soTien = double.tryParse(_soTienController.text) ?? 0;
    final laiSuat = double.tryParse(_laiController.text) ?? 0;
    final soNam = double.tryParse(_soNamController.text) ?? 0;

    if (soTien <= 0 || laiSuat <= 0) {
      setState(() => _ketQua = 'Vui lòng nhập Số tiền và Lãi hàng năm (> 0)!');
      return;
    }

    double lai = 0;
    double tongTien = 0;
    double namGapDoi = 0;

    if (_loaiLai == 'Lãi suất đơn') {
      // Tính lãi theo số năm nhập
      if (soNam > 0) {
        lai = soTien * laiSuat * soNam / 100;
        tongTien = soTien + lai;
      }
      // Số năm để tiền tăng gấp đôi (từ lãi hàng năm)
      namGapDoi = 100 / laiSuat;
    } else {
      // Lãi suất kép
      if (soNam > 0) {
        tongTien = soTien * pow((1 + laiSuat / 100), soNam);
        lai = tongTien - soTien;
      }
      // Số năm để tiền tăng gấp đôi (Rule of 72)
      namGapDoi = 72 / laiSuat;
    }

    setState(() {
      _ketQua = 'Loại: $_loaiLai\n\n'
          'Số tiền lãi: ${lai.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} VNĐ\n'
          'Tổng tiền: ${tongTien.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} VNĐ\n\n'
          'Số năm để tiền tăng gấp đôi: ${namGapDoi.toStringAsFixed(2)} năm '
          '(${_loaiLai == "Lãi suất đơn" ? "100 / lãi suất" : "Rule of 72"})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Máy tính lãi suất'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _loaiLai,decoration: const InputDecoration(
                labelText: 'Chọn loại lãi suất',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Lãi suất đơn', child: Text('Lãi suất đơn')),
                DropdownMenuItem(value: 'Lãi suất kép', child: Text('Lãi suất kép')),
              ],
              onChanged: (value) {
                setState(() {
                  _loaiLai = value!;
                  _ketQua = '';
                });
              },
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _soTienController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số tiền',
                hintText: 'Nhập số tiền gốc (VNĐ)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _laiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Lãi hàng năm',
                hintText: 'Nhập lãi suất (%/năm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _soNamController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số năm',
                hintText: 'Nhập số năm (để tính lãi)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _tinhToan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Tính toán'),
              ),
            ),
            const SizedBox(height: 32),

            if (_ketQua.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  _ketQua,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}