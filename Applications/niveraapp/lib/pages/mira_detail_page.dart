import 'package:flutter/material.dart';


class MiraDetailPage extends StatefulWidget {
  const MiraDetailPage({super.key});

  @override
  State<MiraDetailPage> createState() => _MiraDetailPageState();
}

class _MiraDetailPageState extends State<MiraDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product images
            SizedBox(
              height: 300,
              child: PageView(
                children: [
                  Image.network('https://firebasestorage.googleapis.com/v0/b/niveraapp-c5658.appspot.com/o/Boards%2Flab1.png?alt=media&token=f6ec297f-deaa-48e5-b995-2adf4f3460cb', fit: BoxFit.scaleDown),
                  Image.network('https://firebasestorage.googleapis.com/v0/b/niveraapp-c5658.appspot.com/o/Boards%2Flab2.png?alt=media&token=0c59c84b-f8ce-4bd6-82dc-538f90eabe8a', fit: BoxFit.scaleDown),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Product name
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Mira Electronic Laboratory Kit',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Product description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'This electronic development board allows you to develop your projects quickly and easily. It is compatible with various sensors and modules and offers high performance with its powerful processor.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Product features
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FeatureItem('High performance processor'),
                  FeatureItem('Compatibility with various sensors and modules'),
                  FeatureItem('Easy programmable interface'),
                  FeatureItem('Durable and compact design'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Product specifications
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Technical Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpecificationItem('MCU', 'ESP32-WROOM-32'),
                  SpecificationItem('Max frequency', '240 MHz'),
                  SpecificationItem('Memory', '4 MB Flash, 320 KB RAM'),
                  SpecificationItem('Giriş/Çıkış Pinleri', '32 pin'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Buy button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Buy'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}




class FeatureItem extends StatelessWidget {
  final String feature;
  const FeatureItem(this.feature, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(child: Text(feature, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class SpecificationItem extends StatelessWidget {
  final String title;
  final String value;
  const SpecificationItem(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
